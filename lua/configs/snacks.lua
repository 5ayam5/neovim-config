---@module 'snacks'

local M = {}

---@type snacks.config
M.opts = {}

M.opts.picker = {
  win = {
    input = {
      keys = {
        ["<a-s>"] = { "flash", mode = { "n", "i" } },
        ["s"] = { "flash" },
      },
    },
  },
  actions = {
    flash = function(picker)
      require("flash").jump {
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
            end,
          },
        },
        action = function(match)
          local idx = picker.list:row2idx(match.pos[1])
          picker.list:_move(idx, true, true)
        end,
      }
    end,
  },
}

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

return M
