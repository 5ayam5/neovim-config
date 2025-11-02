-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",

  integrations = {
    "blink",
    "blink-pair",
    "flash",
    "markview",
    "todo",
    "syntax",
    "dap",
  },

  hl_add = {
    SnacksPicker = { bg = "darker_black" },
    SnacksPickerBorder = { fg = "darker_black", bg = "darker_black" },

    SnacksTitle = { fg = "black", bg = "red" }, -- NOTE: using this since SnacksPickerBoxTitle does not work
    SnacksPickerToggle = { fg = "black", bg = "orange" },
    SnacksPickerListCursorLine = { fg = "white", bg = "black2" },
    SnacksPickerPreviewTitle = { fg = "black", bg = "green" },

    SnacksInputTitle = { link = "@comment.danger" },
    SnacksInputBorder = { link = "Removed" },
    SnacksInputIcon = { link = "Removed" },
  },

  hl_override = {},
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⢈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⢀⣴⣷⣄ ⠌⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⢀⣴⣿⣿⣿⣿⣦⠀⠀⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⠀⢀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣀⣀⠀⠈⠉⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠁⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⣀⠀⠉⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⠿⠟⠛⠛⠿⢿⣿⣿⠿⠋⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠻⣿⣿⣿",
    "⣿⡿⠛⠁⢀⣠⣤⣤⡀⠀⠉⠁⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠈⠙⠿⠿⠛⠉⠀⢀⣀⡀⠀⢿⣿⣿",
    "⣿⠀⠀⣰⣿⡏⢹⣿⣿⣶⡀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⢀⣠⣴⣾⣿⣿⡇⠀⣸⣿⣿",
    "⣿⠀⢠⣿⠿⣷⠿⢿⣭⣼⣿⣦⠀⢹⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣸⣿⣿",
    "⣿⠀⢸⣿⣤⡟⢴⡦⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣿⣿⣿",
    "⣿⠀⠘⣿⣿⣿⣬⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣴⣿⣿⡇⠘⠛⠛⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⢀⣿⣿⣿",
    "⣿⠀⠀⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣄⠈⠉⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⣾⣿⣿⣿",
    "⣿⣷⣤⣄⣀⡀⠀⠈⠉⠙⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⢰⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣄⣀⡀⠀⠈⠉⠙⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⢻⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⣤⣄⣀⡀⠀⠈⠉⠙⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⢻⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣤⣤⣀⣀⠀⠈⠉⠉⠛⠛⠿⢿⣿⣿⣿⡿⠋⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀ ⠻⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣤⣤⣀⣀⠀⠈⠉⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀ ⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⣿⣿⣿⣿⡇ ⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠹⣿⣿⣿⣿⣿⣿⡿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠛⠻⠿⢿⣿⣿⣿⠀⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀ ⠈⠉⠁⠀⠀⢀⣠⣶⣶⣾⣿⣿⣿⣶⣦⣤⣤⣀⠀⠀⢈⠉⠀⣿",
    "",
    "  Powered By  eovim ",
    "                      ",
  },

  ---@diagnostic disable-next-line : assign-type-mismatch
  buttons = require "nvdash",
}

M.ui = {
  tabufline = {
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs" },
  },

  cmp = {
    style = "atom_colored",
  },
}

M.lsp = {
  signature = false,
}

return M
