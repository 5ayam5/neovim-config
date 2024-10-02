-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "pyright", "ruff_lsp" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local custom_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    nvlsp.on_attach(client, bufnr)
  end

lspconfig.clangd.setup {
  on_attach = custom_attach,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
  -- init_options = {
  --  compilationDatabasePath = './debug'
  -- },
}
