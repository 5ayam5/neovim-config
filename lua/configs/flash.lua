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

local flash_forward = function()
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
end

local flash_backward = function()
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
end

M.keys = {
  {
    "<leader>ss",
    mode = { "n" },
    flash_forward,
    desc = "Flash forward search",
  },
  {
    "s",
    mode = { "x", "o" },
    flash_forward,
    desc = "Flash forward search",
  },

  {

    "<leader>sS",
    mode = { "n" },
    flash_backward,
    desc = "Flash backward search",
  },
  {
    "S",
    mode = { "x", "o" },
    flash_backward,
    desc = "Flash backward search",
  },

  {
    "t",
    mode = { "x", "o" },
    function()
      require("flash").treesitter()
    end,
    desc = "Flash treesitter",
  },
  {
    "T",
    mode = { "x", "o" },
    function()
      require("flash").treesitter_search()
    end,
    desc = "Flash treesitter search",
  },
}

return M
