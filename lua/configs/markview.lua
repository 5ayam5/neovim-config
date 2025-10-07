dofile(vim.g.base46_cache .. "markview")

---@module 'markview'
---@type markview.config
local M = {}

M.markdown = require "markview.config.markdown"

M.markdown.headings = require("markview.presets").headings.numbered
M.markdown.list_items.marker_minus.text = function(_, item) ---@diagnostic disable-line: assign-type-mismatch
  ---@cast item markview.parsed.markdown.list_items
  local index = (item.indent / 2) % 4
  if index == 0 then
    return "●"
  elseif index == 1 then
    return "○"
  elseif index == 2 then
    return "◈"
  elseif index == 3 then
    return "◇"
  end
end

M.preview = {
  icon_provider = "devicons",

  hybrid_modes = { "n", "i" },
  linewise_hybrid_mode = true,
}

return M
