local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

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

autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

autocmd("BufReadPre", {
  pattern = "*",
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
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- this and the autocmd is to save and restore folds
autocmd("BufWinLeave", {
  pattern = "*",
  command = "silent! mkview",
})
autocmd("BufWinEnter", {
  pattern = "*",
  command = "silent! loadview",
})

autocmd("LspProgress", {
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
local imb = function(e) -- init molten buffer
  vim.schedule(function()
    local kernels = vim.fn.MoltenAvailableKernels()
    local try_kernel_name = function()
      local metadata = vim.json.decode(io.open(e.file, "r"):read "a")["metadata"]
      return metadata.kernelspec.name
    end
    local ok, kernel_name = pcall(try_kernel_name)
    if not ok or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil
      local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
      if venv ~= nil then
        kernel_name = string.match(venv, "/.+/(.+)")
      end
    end
    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end
    vim.cmd "MoltenImportOutput"
  end)
end

-- automatically import output chunks from a jupyter notebook
autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  callback = function(e)
    if vim.api.nvim_get_vvar "vim_did_enter" ~= 1 then
      imb(e)
    end
  end,
})

-- automatically export output chunks to a jupyter notebook on write
autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  callback = function()
    if require("molten.status").initialized() == "Molten" then
      vim.cmd "MoltenExportOutput!"
    end
  end,
})
