---@module 'snacks'

local M = {}

M.opts = {}

---@type snacks.picker.config
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

M.keys = {
  --@TODO: find a way to show list of terminals
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
    "<leader>fh",
    function()
      Snacks.picker.help()
    end,
    desc = "Find help",
  },
  {
    "<leader>fc",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Find in current buffer",
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
    "<leader>g",
    function()
      Snacks.lazygit()
    end,
    desc = "Git open lazygit",
  },

  -- todo_comments
  {
    "<leader>ft",
    function()
      ---@diagnostic disable-next-line: undefined-field
      Snacks.picker.todo_comments()
    end,
    desc = "Find TODO comments",
  },
}

return M
