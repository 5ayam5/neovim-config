vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.bo[args.buf].buflisted then
      local recent_folders = vim.g.RECENT_PROJECTS or {}

      local pwd = vim.uv.cwd()
      local home = os.getenv "HOME" .. "/"

      if not (home ~= pwd and not vim.tbl_contains(recent_folders, pwd)) then
        return
      end

      if #recent_folders == 5 then
        table.remove(recent_folders, 1)
      end

      table.insert(recent_folders, pwd)
      vim.g.RECENT_PROJECTS = recent_folders
    end
  end,
})

local home = os.getenv "HOME" .. "/"

local replace_home_path = function(path)
  if path:find(home) then
    return "~/" .. string.gsub(path, "^" .. home, "")
  end
  return path
end

local letters = {}
for i = string.byte "a", string.byte "z" do
  local letter = string.char(i)
  if not vim.tbl_contains({ "j", "k", "h", "l", "s", "f", "g", "q" }, letter) then
    table.insert(letters, letter)
  end
end

local function set_recent_files(tb)
  local files = {}

  local cwd = vim.uv.cwd()
  for _, v in ipairs(vim.v.oldfiles) do
    if #files == 5 then
      break
    end
    if vim.uv.fs_stat(v) then
      local abs = vim.uv.fs_realpath(v)
      if abs and abs:sub(1, #cwd) == cwd then
        table.insert(files, v)
      end
    end
  end

  for i, v in ipairs(files) do
    local devicon, devicon_hl = require("nvim-web-devicons").get_icon(v)
    local icon = devicon or ""
    local path = replace_home_path(vim.uv.fs_realpath(v):sub(#cwd + 2)):sub(1, 75)
    local keybind = letters[i]

    local line = {
      multicolumn = true,
      no_gap = true,
      content = "fit",
      group = "recent_files",
      cmd = "e " .. v,
      keys = keybind,
    }

    table.insert(line, { txt = icon .. "  ", hl = devicon_hl })
    table.insert(line, { txt = path })
    table.insert(line, { txt = string.rep(" ", 3), pad = "full" })
    table.insert(line, { txt = keybind, hl = "comment" })

    table.insert(tb, line)
  end
end

local function set_recent_folders(tb)
  local dirs = vim.g.RECENT_PROJECTS or {}
  dirs = vim.list_slice(dirs, 0, 5)

  for i, v in ipairs(dirs) do
    local path = replace_home_path(v):sub(-75)
    local keybind = letters[i + 5]

    local line = {
      keys = keybind,
      multicolumn = true,
      no_gap = true,
      content = "fit",
      group = "recent_files",
      cmd = "cd " .. v,
    }

    table.insert(line, { txt = "  ", hl = "nviminternalError" })
    table.insert(line, { txt = path })
    table.insert(line, { txt = string.rep(" ", 3), pad = "full" })
    table.insert(line, { txt = keybind, hl = "comment" })

    table.insert(tb, line)
  end
end

return function()
  local layout = {

    {
      multicolumn = true,
      pad = 3,
      content = "fit",
      { txt = "  Lazy sync [s]", hl = "changed", keys = "s", cmd = "Lazy sync" },
      { txt = "  Files [f]", hl = "Added", keys = "f", cmd = "lua Snacks.picker.files()" },
      { txt = " Lazygit [g]", hl = "Function", keys = "g", cmd = "lua Snacks.lazygit()" },
      { txt = "✖  Quit [q]", hl = "nviminternalError", keys = "q", cmd = "qa" },
    },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "comment",
      content = "fit",
    },

    {
      txt = "  Most Recent files",
      hl = "floatborder",
      no_gap = true,
      group = "recent_files",
    },

    { txt = "─", hl = "comment", no_gap = true, rep = true, group = "recent_files", content = "fit" },
  }

  set_recent_files(layout)
  table.insert(layout, { txt = "", no_gap = true })

  table.insert(layout, {
    txt = "  Recent Projects",
    hl = "String",
    no_gap = true,
    group = "recent_files",
  })

  table.insert(
    layout,
    { txt = "─", hl = "comment", no_gap = true, rep = true, group = "recent_files", content = "fit" }
  )

  set_recent_folders(layout)

  return layout
end
