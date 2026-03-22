dofile(vim.g.base46_cache .. "markview")

---@module 'markview'
---@type markview.config
local M = {}

M.markdown = require "markview.config.markdown"

for i = 1, 6 do
  M.markdown.headings["heading_" .. i].icon = require("markview.presets").headings.numbered["heading_" .. i].icon
end

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

  filetypes = {
    "markdown",
    "codecompanion",
  },

  condition = function(buffer)
    if vim.bo[buffer].filetype == "codecompanion" then
      return true
    else
      return nil
    end
  end,
}

return M
