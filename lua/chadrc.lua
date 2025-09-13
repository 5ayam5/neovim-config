-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

local M = {}

M.base46 = {
  theme = "kanagawa",

  integrations = {
    "flash",
  },

  --@FIXME: fix this to look pretty
  -- hl_add = {
  --   SnacksPicker = { bg = "darker_black" },
  --   SnacksPickerPrompt = { fg = "blue", bg = "black2" },
  --   SnacksPickerInput = { fg = "blue", bg = "black2" },
  --   SnacksPickerPreview = { bg = "darker_black" },
  --   SnacksPickerTitle = { fg = "black2", bg = "yellow", bold = true },
  --   SnacksPickerInputTitle = { fg = "black", bg = "red", bold = true },
  --   SnacksPickerPreviewTitle = { fg = "black", bg = "green", bold = true },
  --   SnacksPickerListTitle = { fg = "black", bg = "black", bold = true },
  --   -- SnacksInputNormal = { fg = "blue", bg = "darker_black" },
  --   -- Borderless
  --   SnacksPickerBorder = { fg = "darker_black", bg = "darker_black" },
  --   SnacksPickerInputBorder = { fg = "black2", bg = "black2" },
  --   SnacksPickerListBorder = { fg = "darker_black", bg = "darker_black" },
  --   SnacksPickerBoxBorder = { fg = "darker_black", bg = "darker_black" },
  --   SnacksPickerPreviewBorder = { fg = "darker_black", bg = "darker_black" },
  --   -- SnacksInputBorder = { fg = "darker_black", bg = "darker_black" },
  -- },
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
