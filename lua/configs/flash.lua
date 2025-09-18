dofile(vim.g.base46_cache .. "flash")

local M = {}

M.opts = {
  modes = {
    char = {
      jump_labels = true,
    },
  },
  label = {
    style = "eol",
  },
  exclude = {
    "blink-cmp-menu",
    "blink-cmp-documentation",
    "blink-cmp-signature",
  },
}

M.keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump {
        remote_op = {
          restore = true,
          motion = nil,
        },
        jump = { pos = "end" },
        search = {
          forward = true,
          wrap = false,
          multi_window = false,
        },
      }
    end,
    desc = "Flash",
  },
  {

    "S",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump {
        remote_op = {
          restore = true,
          motion = nil,
        },
        search = {
          forward = false,
          wrap = false,
          multi_window = false,
        },
      }
    end,
    desc = "Flash",
  },
  {
    "r",
    mode = { "n", "x", "o" },
    function()
      require("flash").treesitter()
    end,
    desc = "Flash Treesitter",
  },
  {
    "R",
    mode = { "o", "x" },
    function()
      require("flash").treesitter_search()
    end,
    desc = "Treesitter Search",
  },
}

return M
