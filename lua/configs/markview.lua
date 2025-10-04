dofile(vim.g.base46_cache .. "markview")

---@module 'markview'
---@type markview.config
local M = {}

M.markdown = { ---@diagnostic disable-line: missing-fields
  headings = require("markview.presets").headings.numbered,
}

M.preview = {
  icon_provider = "devicons",

  hybrid_modes = { "n", "i" },
  linewise_hybrid_mode = true,
}

return M
