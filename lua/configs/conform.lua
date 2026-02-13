---@module "conform"
---@type conform.setupOpts
local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    jupy = { "jupytext_ruff_chain" },
    markdown = { "mdformat" },
    tex = { "tex-fmt" },
    bib = { "tex-fmt" },
  },

  formatters = {
    jupytext_ruff_chain = {
      command = "sh",
      args = {
        "-c",
        "t=$(mktemp).ipynb; trap 'rm -f \"$t\"' EXIT; "
          .. 'jupytext --from py:percent --to ipynb -o "$t" - --quiet 2> /dev/null || exit 1; '
          .. 'ruff check --fix "$t" > /dev/null 2>&1 || true; '
          .. 'ruff format "$t" > /dev/null 2>&1 || true; '
          .. 'ruff check --select I --fix "$t" > /dev/null 2>&1 || true; '
          .. 'jupytext --from ipynb --to py:percent -o - "$t"',
      },
      stdin = true,
    },
  },

  format_on_save = function(bufnr)
    if vim.b.disable_autoformat then
      return
    end
    return { timeout_ms = 2000, lsp_format = "fallback" }
  end,
}

return options
