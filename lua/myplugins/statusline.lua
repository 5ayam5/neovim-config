local modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  [""] = { "V-BLOCK", "Visual" },

  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT", "Insert" },
  ["ix"] = { "INSERT", "Insert" },

  ["t"] = { "TERMINAL", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [""] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["cr"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

local separators = {
  prefix = "",
  suffix = "",
}

local max_widths = {
  file = 60,
  cwd = 60,
  diagnostics = 20,
  lsp = 40,
  git = 40,
}

local min_widths = {
  space = 0,
  mode = math.huge,
  file = 10,
  cwd = 10,
  cursor = math.huge,
  diagnostics = 0,
  lsp = 0,
  git = 0,
}

local width_priority = {
  "space",
  "mode",
  "file",
  "cwd",
  "cursor",
  "diagnostics",
  "lsp",
  "git",
}

local get_buffer_number = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local order = {
  "space",
  "mode",
  "space",
  "file",
  "%=",
  "diagnostics",
  "lsp",
  "git",
  "%=",
  "cwd",
  "space",
  "cursor",
  "space",
}

local elements = {}

elements.space = "%#St_space#" .. " "

elements.mode = function()
  if vim.api.nvim_get_current_win() ~= vim.g.statusline_winid then
    return ""
  end
  local mode = vim.api.nvim_get_mode().mode

  local mode_prefix = "%#St_" .. modes[mode][2] .. "ModeSep#" .. separators.prefix
  local current_mode = "%#St_" .. modes[mode][2] .. "Mode# " .. modes[mode][1]
  local mode_suffix = "%#St_" .. modes[mode][2] .. "ModeSep#" .. separators.suffix
  return mode_prefix .. current_mode .. mode_suffix
end

elements.cwd = function()
  local icon = "%#St_cwd_sep#" .. separators.prefix .. "%#St_cwd_icon#" .. " "
  local name = vim.uv.cwd()
  if not name then
    return ""
  end
  name = name:match "([^/\\]+)[/\\]*$" or name ---@type string
  return icon .. name .. "%#St_cwd_sep#" .. separators.suffix
end

elements.file = function()
  local path = vim.api.nvim_buf_get_name(get_buffer_number())
  local name = path:match "([^/\\]+)[/\\]*$" or "" ---@type string
  local icon = ""
  if name ~= "" then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local devicon = devicons.get_icon(name)
      icon = devicon or ""
    end
  end

  return "%#St_file_sep#"
    .. separators.prefix
    .. "%#St_file#"
    .. icon
    .. " "
    .. name
    .. "%#St_file_sep#"
    .. separators.suffix
end

elements.cursor = "%#St_pos_sep#"
  .. separators.prefix
  .. "%#St_pos_icon#󰇀 "
  .. "%l/%v"
  .. "%#St_pos_sep#"
  .. separators.suffix

elements["%="] = "%="

elements.git = function()
  local buf = get_buffer_number()
  if vim.b[buf] and vim.b[buf].gitsigns_status then
    local git_info = vim.b[buf].gitsigns_status_dict
    local added = (git_info.added and git_info.added ~= 0) and ("  " .. git_info.added) or ""
    local changed = (git_info.changed and git_info.changed ~= 0) and ("  " .. git_info.changed) or ""
    local removed = (git_info.removed and git_info.removed ~= 0) and ("  " .. git_info.removed) or ""
    local branch_name = "  " .. git_info.head

    return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed .. " "
  end

  return ""
end

elements.lsp = function()
  if not rawget(vim, "lsp") then
    return ""
  end
  local clients = ""
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.attached_buffers and client.attached_buffers[get_buffer_number()] then
      clients = clients .. "[" .. client.name .. "]"
    end
  end
  if clients == "" then
    return ""
  elseif clients:len() > 24 then
    clients = clients:sub(1, 20) .. "...]"
  end
  return "%#St_Lsp#  LSP " .. clients
end

elements.diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local get_count_string = function(severity, icon)
    local count = #vim.diagnostic.get(get_buffer_number(), { severity = severity })
    return (count and count > 0) and (icon .. " " .. count .. " ") or ""
  end

  local err = get_count_string(vim.diagnostic.severity.ERROR, "%#St_lspError#" .. "")
  local warn = get_count_string(vim.diagnostic.severity.WARN, "%#St_lspWarning#" .. "")
  local info = get_count_string(vim.diagnostic.severity.INFO, "%#St_lspInfo#" .. "")
  local hints = get_count_string(vim.diagnostic.severity.HINT, "%#St_lspHints#" .. "")

  return " " .. err .. warn .. info .. hints
end

return function()
  local function rendered_width(s)
    local ok, evaluated = pcall(vim.api.nvim_eval_statusline, s, {
      winid = vim.g.statusline_winid or 0,
    })
    if ok then
      return evaluated.width
    end
    return vim.fn.strdisplaywidth(s:gsub("%%#.-#", ""):gsub("%%[=<]", ""))
  end

  local function truncate(part, width)
    if width == math.huge or rendered_width(part) <= width then
      return part
    end
    if width <= 0 then
      return ""
    end

    return "%." .. width .. "(" .. part .. "%)"
  end

  local parts = {}
  local by_key = {}
  for _, key in ipairs(order) do
    local v = elements[key]
    local part = type(v) == "string" and v or v()
    local item = {
      key = key,
      part = part,
      width = rendered_width(part),
      min_width = min_widths[key],
      max_width = max_widths[key] or math.huge,
      allocated_width = 0,
      visible = min_widths[key] == nil,
    }
    table.insert(parts, item)

    if min_widths[key] ~= nil then
      by_key[key] = by_key[key] or {}
      table.insert(by_key[key], item)
    end
  end

  local available_width = vim.o.columns
  local consumed_width = 0

  for _, key in ipairs(width_priority) do
    local min_width = min_widths[key]
    if min_width and min_width > 0 then
      for _, item in ipairs(by_key[key] or {}) do
        local needed_width = math.min(item.width, min_width)
        consumed_width = consumed_width + needed_width
        if consumed_width > available_width then
          return ""
        end
        item.visible = true
        item.allocated_width = needed_width
      end
    end
  end

  for _, key in ipairs(width_priority) do
    if min_widths[key] == 0 then
      for _, item in ipairs(by_key[key] or {}) do
        item.visible = true
      end
    end
  end

  for _, key in ipairs(width_priority) do
    for _, item in ipairs(by_key[key] or {}) do
      if item.visible then
        local target_width = math.min(item.width, item.max_width)
        local extra_width = math.min(target_width - item.allocated_width, available_width - consumed_width)
        if extra_width > 0 then
          item.allocated_width = item.allocated_width + extra_width
          consumed_width = consumed_width + extra_width
        end
        if consumed_width >= available_width then
          break
        end
      end
    end
  end

  local statusline = {}
  for _, item in ipairs(parts) do
    if item.visible then
      table.insert(statusline, item.min_width == nil and item.part or truncate(item.part, item.allocated_width))
    end
  end

  return table.concat(statusline)
end
