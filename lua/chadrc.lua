-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",

  integrations = {
    "flash",
  },

  hl_add = {
    SnacksPicker = { bg = "one_bg" },
    SnacksPickerTitle = { fg = "nord_blue", bg = "one_bg", bold = true },
    SnacksPickerPrompt = { fg = "red", bg = "one_bg" },
    SnacksPickerInput = { fg = "yellow", bg = "one_bg" },
    SnacksPickerTotals = { fg = "green", bg = "one_bg", bold = true },
    SnacksPickerInputBorder = { fg = "nord_blue", bg = "one_bg" },
    SnacksPickerBoxBorder = { fg = "nord_blue", bg = "one_bg" },
    SnacksPickerPreview = { bg = "one_bg" },
    SnacksPickerPreviewBorder = { fg = "white", bg = "one_bg" },
    SnacksPickerPreviewTitle = { fg = "white", bg = "one_bg", bold = true },
    SnacksPickerList = { fg = "white", bg = "one_bg" },
    SnacksPickerBorder = { fg = "one_bg", bg = "one_bg" },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "⠀⠀⠀⠀⠀⠀⢀⡤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⡏⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⣀⠴⠋⠉⠉⡆⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠈⠉⠉⠙⠓⠚⠁⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀⠀",
    "⠀⠀⠀⠀⡞⠀⠀⠀⠀⠀⠶⠀⠀⠀⠀⠀⠀⠦⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀",
    "⢠⣤⣶⣾⣧⣤⣤⣀⡀⠀⠀⠀⠀⠈⠀⠀⠀⢀⡤⠴⠶⠤⢤⡀⣧⣀⣀⠀",
    "⠻⠶⣾⠁⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⠀⠀⠀⢹⣿⣭⣽⠇",
    "⠀⠀⠙⠤⠴⢤⡤⠤⠤⠋⠉⠉⠉⠉⠉⠉⠉⠳⠖⠦⠤⠶⠦⠞⠁⠀⠀⠀",
    "",
    "  Powered By  eovim ",
    "                      ",
  },

  ---@diagnostic disable-next-line : assign-type-mismatch
  buttons = require "nvdash",
}

M.cheatsheet = {
  excluded_groups = { "autopairs" },
}

M.ui = {
  tabufline = {
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs" },
  },
  statusline = {
    theme = "vscode_colored",
  },

  cmp = {
    style = "atom_colored",
  },
}

M.term = {
  winopts = { number = true, relativenumber = true },
}

M.lsp = {
  signature = false,
}

return M
