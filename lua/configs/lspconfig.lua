dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local M = {}
local map = vim.keymap.set

--@TODO: customize the keybindings
-- export on_attach & capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
  end,
})

-- disable semanticTokens
M.on_init = function(client, _)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local servers = {
  pyright = {},
  ruff = {},
  clangd = {},
}

servers.texlab = {
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
}

servers.lua_ls = {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types" } },
    },
  },
}

vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
