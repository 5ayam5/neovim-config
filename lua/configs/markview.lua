dofile(vim.g.base46_cache .. "markview")

---@module 'markview'
---@type markview.config
local M = {}

M.markdown = require "markview.config.markdown"

M.markdown.headings.heading_1.icon = require("markview.presets").headings.numbered.heading_1.icon ---@diagnostic disable-line: assign-type-mismatch
M.markdown.headings.heading_2.icon = require("markview.presets").headings.numbered.heading_2.icon ---@diagnostic disable-line: assign-type-mismatch
M.markdown.headings.heading_3.icon = require("markview.presets").headings.numbered.heading_3.icon ---@diagnostic disable-line: assign-type-mismatch
M.markdown.headings.heading_4.icon = require("markview.presets").headings.numbered.heading_4.icon ---@diagnostic disable-line: assign-type-mismatch
M.markdown.headings.heading_5.icon = require("markview.presets").headings.numbered.heading_5.icon ---@diagnostic disable-line: assign-type-mismatch
M.markdown.headings.heading_6.icon = require("markview.presets").headings.numbered.heading_6.icon ---@diagnostic disable-line: assign-type-mismatch

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

  modes = { "n", "no" },
  hybrid_modes = { "no" },
}

return M
