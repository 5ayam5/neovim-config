dofile(vim.g.base46_cache .. "dap")

local dap = require "dap"

dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}
