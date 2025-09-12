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
    rainbow = {
      enabled = true,
    },
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
  {
    "<c-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
  },
}

return M
