-- thanks to https://github.com/NvChad/ui/tree/v3.0/lua/nvchad/colorify for the code
local M = {}
local api = vim.api

local state = require "myplugins.colorify.state"
state.ns = api.nvim_create_namespace "Colorify"

M.opts = {
  mode = "virtual",
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

M.run = function()
  api.nvim_create_autocmd({
    "TextChanged",
    "TextChangedI",
    "TextChangedP",
    "VimResized",
    "LspAttach",
    "WinScrolled",
    "BufEnter",
  }, {
    callback = function(args)
      if vim.bo[args.buf].bl then
        local attach = require "myplugins.colorify.attach"
        attach(M.opts, args.buf, args.event)
      end
    end,
  })
end

return M
