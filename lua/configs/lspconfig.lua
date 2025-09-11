require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("texlab", {
  settings = {
    texlab = {
      build = {
        args = {
          "-pdf",
          "--shell-escape",
          "-pv",
          "-e",
          "$pdf_previewer=q/Open -g -a Skim/",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
          "%f",
        },
        onSave = true,
        forwardSearchAfter = true,
      },
      chktex = {
        onOpenAndSave = true,
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" },
      },
    },
  },
})

local servers = { "pyright", "ruff", "clangd", "texlab", "lua-language-server" }
vim.lsp.enable(servers)
