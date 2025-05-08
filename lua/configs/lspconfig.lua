require("nvchad.configs.lspconfig").defaults()

local servers = { "pyright", "ruff", "clangd", "texlab" }
vim.lsp.enable(servers)

vim.lsp.config.texlab.settings = {
  texlab = {
    build = {
      args = { "-pdf","--shell-escape", "-pv","-e","$pdf_previewer=q/Open -g -a Skim/","-synctex=1","-interaction=nonstopmode", "-file-line-error", "%f" },
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
}

-- read :h vim.lsp.config for changing options of lsp servers 
