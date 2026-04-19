dofile(vim.g.base46_cache .. "blink-pair")

--- @module 'blink.pairs'
--- @type blink.pairs.Config
local M = {
  mappings = {
    disabled_filetypes = {
      "snacks_picker_input",
      "vim",
    },
  },
  highlights = {
    groups = {
      "BlinkPairsViolet",
      "BlinkPairsBlue",
      "BlinkPairsPurple",
      "BlinkPairsOrange",
      "BlinkPairsYellow",
    },
  },
}

return M
