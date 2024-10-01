---@type ChadrcConfig
local M = {}

M.base46 = { theme = 'pastelDark' }

M.mason = {
  cmd = true,
  pkgs = {
    "lua-language-server",
    "clangd",
    "clang-format",
    "codelldb",
    "pyright",
    "ruff-lsp",
  }
}

return M
