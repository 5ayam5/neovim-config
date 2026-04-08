local api = vim.api
local get_hl = api.nvim_get_hl
local buf_name = api.nvim_buf_get_name
local cur_buf = api.nvim_get_current_buf
local get_opt_val = api.nvim_get_option_value
local fn = vim.fn

local elements = {}

local function hl_text(str, hl)
  str = str or ""
  return "%#Tb" .. hl .. "#" .. str
end

local function filename(str)
  return str:match "([^/]+)[/]*$"
end

local function new_hl(group1, group2)
  local fg = get_hl(0, { name = group1 }).fg
  local bg = get_hl(0, { name = "Tb" .. group2 }).bg
  api.nvim_set_hl(0, group1 .. group2, { fg = fg, bg = bg })
  return "%#" .. group1 .. group2 .. "#"
end

local function gen_unique_name(name, index)
  for i, bufnr in ipairs(vim.t.bufs) do
    local filepath = filename(buf_name(bufnr))
    if index ~= i and filepath == name then
      return fn.fnamemodify(buf_name(vim.t.bufs[index]), ":h:t") .. "/" .. name
    end
  end
end

local function style_buf(bufnr, index, width)
  local icon = "  "
  local is_curbuf = cur_buf() == bufnr
  local tb_hl_name = "Buf" .. (is_curbuf and "On" or "Off")
  local icon_hl = new_hl("DevIconDefault", tb_hl_name)

  local name = filename(buf_name(bufnr))
  name = name and (gen_unique_name(name, index) or name) or "[No Name]"

  if name ~= "[No Name]" then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local devicon, devicon_hl = devicons.get_icon(name)
      if devicon then
        icon = " " .. devicon .. " "
        icon_hl = new_hl(devicon_hl, tb_hl_name)
      end
    end
  end

  local maxname_len = width - 5 --- 3 for icon, 2 for modified sign, 1 for padding
  if #name > maxname_len then
    name = string.sub(name, 1, maxname_len - 3) .. "..."
  end
  local length = #name
  name = icon_hl .. icon .. hl_text(name, tb_hl_name)

  local modified = get_opt_val("modified", { buf = bufnr })
  if is_curbuf then
    name = (modified and hl_text(" 󰧞", "BufOnModified") or "") .. name
  else
    name = (modified and hl_text(" 󰧞", "BufOffModified") or "") .. name
  end
  length = length + (modified and 2 or 0) + 3

  return hl_text(name, tb_hl_name) .. " ", length
end

local order = { "tree_offset", "buffers", "tabs" }

local function getFileTreeWidth()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win)
    end
  end
  return 0
end

elements.tree_offset = function()
  local w = getFileTreeWidth()
  return w == 0 and "" or "%#NvimTreeNormal#" .. string.rep(" ", w) .. "%#NvimTreeWinSeparator#" .. "│"
end

local bufwidth = 20
local function available_width()
  local str = ""
  for _, key in ipairs(order) do
    if key ~= "buffers" then
      str = str .. elements[key]()
    end
  end

  local consumed_width = api.nvim_eval_statusline(str, { use_tabline = true }).width
  return vim.o.columns - consumed_width
end

elements.buffers = function()
  local buffers = {}
  local has_current = false
  local current_width = 0

  vim.t.bufs = vim.tbl_filter(api.nvim_buf_is_valid, vim.t.bufs)
  for i, bufnr in ipairs(vim.t.bufs) do
    has_current = has_current or (cur_buf() == bufnr)
    local style, buffer_width = style_buf(bufnr, i, bufwidth)
    current_width = current_width + buffer_width
    table.insert(buffers, style)

    if current_width > available_width() then
      if not (has_current and #buffers == 1) then
        table.remove(buffers, 1)
        current_width = current_width - buffer_width
      end
      if has_current then
        break
      end
    end
  end

  return table.concat(buffers) .. hl_text("%=", "Fill")
end

elements.tabs = function()
  local tabs, num_tabs = "", fn.tabpagenr "$"

  if num_tabs > 1 then
    for tabnr = 1, num_tabs do
      local tab_hl = "Tab" .. (tabnr == fn.tabpagenr() and "On" or "Off")
      tabs = tabs .. hl_text(" " .. tabnr .. " ", tab_hl)
    end

    return tabs
  end

  return ""
end

return function()
  local tabline = {}

  for _, key in ipairs(order) do
    table.insert(tabline, elements[key]())
  end

  return table.concat(tabline)
end
