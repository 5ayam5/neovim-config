---@module 'snacks'

local M = {}

---@type snacks.config
M.opts = {}

M.opts.terminal = {
  win = {
    position = "float",
  },
}

M.opts.words = {
  enabled = true,
}

M.keys = {
  -- Snacks picker
  {
    "<leader>fw",
    function()
      Snacks.picker.grep()
    end,
    desc = "Find word",
  },

  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find file",
  },

  {
    "<leader>fa",
    function()
      Snacks.picker.files {
        hidden = true,
        ignored = true,
      }
    end,
    desc = "Find all file",
  },

  {
    "<leader>fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Find buffer",
  },

  {
    "<leader>ch",
    function()
      Snacks.picker.help()
    end,
    desc = "Find help",
  },

  {
    "<leader>fh",
    function()
      Snacks.picker.highlights()
    end,
    desc = "Find highlights",
  },

  {
    "<leader>fc",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Find in open buffer",
  },

  {
    "<leader>fm",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Find keymaps",
  },

  -- LazyGit
  {
    "<leader>gg",
    function()
      Snacks.lazygit.open()
    end,
    desc = "git open lazygit",
  },

  -- todo_comments
  {
    "<leader>ft",
    function()
      require("todo-comments").setup {}
      Snacks.picker.todo_comments {} ---@diagnostic disable-line: undefined-field
    end,
    desc = "Find TODO comments",
  },

  -- buffer delete
  {
    "<leader>w",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete buffer",
  },

  -- jump symbols
  {
    "<C-f>",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Jump symbol forward under cursor",
  },
  {
    "<C-b>",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Jump symbol backward under cursor",
  },
}

-- Terminal toggles
for i = 0, 9 do
  table.insert(M.keys, {
    "<M-" .. i .. ">",
    function()
      Snacks.terminal.toggle(nil, {
        count = i,
      })
    end,
    desc = "Toggle terminal " .. i,
    mode = { "n", "t" },
  })
end

M.opts.notifier = {
  enabled = true,
  level = vim.log.levels.DEBUG,
}

M.opts.image = {
  enabled = true,
  math = { enabled = false },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = M.opts.image.formats,
  callback = function()
    require "snacks.image"
  end,
})

M.opts.input = {
  enabled = true,
  win = {
    width = function(win)
      local len = 0.9
      if type(win.opts.title) == "string" then
        len = math.min(#win.opts.title + 15, math.floor(vim.o.columns * 0.8))
      elseif type(win.opts.title) == "table" then
        len = math.min(#win.opts.title[1][1] + 15, math.floor(vim.o.columns * 0.8))
      end
      return len
    end,
    relative = "cursor",
    row = 1,
    col = 0,
  },
}

M.opts.bigfile = {
  enabled = true,
  size = 100 * 1024 * 1024, -- 100 MB
  setup = function(ctx)
    if vim.fn.exists ":NoMatchParen" ~= 0 then
      vim.cmd [[NoMatchParen]]
    end
    if vim.fn.exists ":LspStop" ~= 0 then
      vim.cmd [[LspStop]]
    else
      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        buffer = ctx.buf,
        callback = function(args)
          vim.schedule(function()
            vim.lsp.buf_detach_client(ctx.buf, args.data.client_id)
          end)
        end,
      })
    end
    Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0, cursorline = false })
    vim.cmd [[syntax off]]
    pcall(function()
      require("indent_blankline.commands").disable()
    end)

    vim.api.nvim_clear_autocmds {
      event = "CursorMoved",
      buffer = ctx.buf,
    }
  end,
}

return M
