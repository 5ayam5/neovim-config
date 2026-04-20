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

local min_widths = {
  space = 1,
  mode = (function()
    local max_mode_length = 0
    for _, mode_info in pairs(modes) do
      local mode_length = mode_info[1]:len()
      if mode_length > max_mode_length then
        max_mode_length = mode_length
      end
    end
    return max_mode_length + 4
  end)(),
  file = 30,
  cwd = 20,
  cursor = 10,
  diagnostics = 0,
  lsp = 0,
  git = 0,
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
  if vim.o.columns < 100 then
    return ""
  end
  local icon = "%#St_cwd_sep#" .. separators.prefix .. "%#St_cwd_icon#" .. " "
  local name = vim.uv.cwd()
  if not name then
    return ""
  end
  name = name:match "([^/\\]+)[/\\]*$" or name ---@type string
  if name:len() > 23 then
    name = "..." .. name:sub(-10)
  end
  return icon .. name .. "%#St_cwd_sep#" .. separators.suffix
end

elements.file = function()
  local path = vim.api.nvim_buf_get_name(get_buffer_number())
  local name = path:match "([^/\\]+)[/\\]*$" or "" ---@type string
  if name:len() > 23 then
    name = "..." .. name:sub(-20)
  end
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
  if vim.o.columns >= 75 and vim.b[get_buffer_number()].gitsigns_status then
    local git_info = vim.b[get_buffer_number()].gitsigns_status_dict
    local added = (git_info.added and git_info.added ~= 0) and ("  " .. git_info.added) or ""
    local changed = (git_info.changed and git_info.changed ~= 0) and ("  " .. git_info.changed) or ""
    local removed = (git_info.removed and git_info.removed ~= 0) and ("  " .. git_info.removed) or ""
    local branch_name = "  " .. git_info.head

    return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed .. " "
  end

  return ""
end

elements.lsp = function()
  if vim.o.columns >= 75 and rawget(vim, "lsp") then
    local clients = ""
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[get_buffer_number()] then
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

  return ""
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
  local statusline = {}

  for _, key in ipairs(order) do
    local v = elements[key]
    table.insert(statusline, type(v) == "string" and v or v())
  end
  return table.concat(statusline, "")
end
