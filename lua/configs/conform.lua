---@module "conform"
---@type conform.setupOpts
local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    markdown = { "mdformat" },
    tex = { "tex-fmt" },
    bib = { "tex-fmt" },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

return options
