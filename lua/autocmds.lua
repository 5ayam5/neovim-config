local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- user event that loads after UIEnter + only if file buf is there
augroup("CustomFilePost", { clear = true })
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = "CustomFilePost",
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

autocmd("BufReadPost", {
  pattern = "*",
  group = "CustomFilePost",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

augroup("BlinkCopilotToggle", { clear = true })
autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  group = "BlinkCopilotToggle",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  group = "BlinkCopilotToggle",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

augroup("BigFile", { clear = true })
autocmd("BufReadPre", {
  pattern = "*",
  group = "BigFile",
  callback = function()
    local BIGSIZE = 100 * 1024 * 1024 -- 100 MB
    -- get size of file
    local file = vim.fn.expand "<afile>"
    local size = vim.fn.getfsize(file)
    if size == -2 or size >= BIGSIZE then
      vim.b.bigfile = true
      vim.b.pairs = false
      vim.schedule(function()
        vim.notify(
          ("Opened big file (%s), disabling features for performance"):format(
            vim.fn.printf("%.2f MB", size / (1024 * 1024))
          ),
          vim.log.levels.WARN,
          { title = "BigFile" }
        )
      end)
    end
  end,
})

autocmd("FileType", {
  pattern = "*",
  group = "BigFile",
  callback = function()
    if vim.b.bigfile then
      vim.bo.filetype = "bigfile"
      local buf = vim.api.nvim_get_current_buf()

      if vim.fn.exists ":NoMatchParen" ~= 0 then
        vim.cmd [[NoMatchParen]]
      end

      if vim.fn.exists ":LspStop" ~= 0 then
        vim.cmd [[LspStop]]
      else
        vim.api.nvim_create_autocmd({ "LspAttach" }, {
          buffer = buf,
          callback = function(args)
            vim.schedule(function()
              vim.lsp.buf_detach_client(buf, args.data.client_id)
            end)
          end,
        })

        vim.cmd [[syntax off]]
        pcall(function()
          require("indent_blankline.commands").disable()
        end)

        vim.api.nvim_clear_autocmds {
          event = "CursorMoved",
          buffer = buf,
        }

        -- set foldmethd to manual
        vim.bo.foldmethod = "manual"
        vim.bo.statuscolumn = ""
        vim.bo.conceallevel = 0
      end
      return
    end

    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("LuasnipUnlinkOnInsertLeave", { clear = true }),
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- this and the next autocmd is to save and restore folds
augroup("RememberFolds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*",
  group = "RememberFolds",
  callback = function(args)
    if vim.b[args.buf].view_activated then
      vim.cmd.mkview { mods = { emsg_silent = true } }
    end
  end,
})
autocmd("BufWinEnter", {
  pattern = "*",
  group = "RememberFolds",
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
      if buftype == "" and filetype and filetype ~= "" then
        vim.b[args.buf].view_activated = true
        vim.cmd.loadview { mods = { emsg_silent = true } }
      end
    end
  end,
})

autocmd("LspProgress", {
  group = augroup("LspProgress", { clear = true }),
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function() -- init molten buffer
  vim.schedule(function()
    vim.cmd "MoltenImportOutput"
  end)
end
augroup("MoltenAutocommands", { clear = true })

-- automatically import output chunks from a jupyter notebook
autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  group = "MoltenAutocommands",
  callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  group = "MoltenAutocommands",
  callback = function()
    if vim.api.nvim_get_vvar "vim_did_enter" ~= 1 then
      imb()
    end
  end,
})

-- automatically export output chunks to a jupyter notebook on write
autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  group = "MoltenAutocommands",
  callback = function()
    if require("molten.status").initialized() == "Molten" then
      vim.cmd "MoltenExportOutput!"
    end
  end,
})

autocmd("BufWritePost", {
  pattern = vim.tbl_map(function(path)
    local realpath = vim.uv.fs_realpath(path)
    if not realpath then
      return [[^\b$]]
    end
    return vim.fs.normalize(realpath)
  end, vim.fn.glob(vim.fn.stdpath "config" .. "/lua/**/*.lua", true, true, true)),

  group = augroup("ReloadNvChad", { clear = true }),

  callback = function(opts)
    local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

    -- TODO: rewrite this
    -- require("nvchad.utils").reload(module)
  end,
})

require "myplugins.tabline.autocmds"
