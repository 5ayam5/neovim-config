-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "pyright", "ruff" }
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

lspconfig.texlab.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
  settings = {
    texlab = {
      build = {
        args = { "-pdf","-pv","-e","$pdf_previewer=q/Open -g -a Skim/","-synctex=1","-interaction=nonstopmode", "-file-line-error", "%f" },
        onSave = true,
        forwardSearchAfter = true,
      },
      chktex = {
        onOpenAndSave = true
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" }
      },
    },
  },
}
