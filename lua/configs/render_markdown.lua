dofile(vim.g.base46_cache .. "render-markdown")

---@module 'render-markdown'
---@type render.md.UserConfig
local M = {}

M.completions = {
  lsp = {
    enabled = true,
  },
}

M.render_modes = { "n", "t" }

M.enabled = true

return M
