dofile(vim.g.base46_cache .. "flash")

local M = {}

M.opts = {
  modes = {
    --@FIXME: this is buggy when match is outside of screen
    -- search = {
    --   enabled = true,
    -- },
    char = {
      jump_labels = true,
    },
  },
  jump = {
    nohlsearch = true,
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
      require("flash").jump { remote_op = {
        restore = true,
        motion = nil,
      } }
    end,
    desc = "Flash",
  },
  {
    "S",
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
