local o = vim.o
local opt = vim.opt
local g = vim.g

-- Appearance
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"
opt.fillchars = { eob = " " }
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true

-- Editing
o.clipboard = "unnamedplus"
o.undofile = true

-- Cursor
o.cursorline = true
o.cursorlineopt = "both"
o.relativenumber = true
o.number = true
o.numberwidth = 2
o.ruler = false
o.scrolloff = 999

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- Search
o.ignorecase = true
o.smartcase = true

-- Time
o.updatetime = 250
o.timeoutlen = 400

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Miscellaneous
g.tex_flavor = "latex"

-- Enable/Disable language providers
local enable_providers = {
  "python3",
}
for _, plugin in pairs(enable_providers) do
  g["loaded_" .. plugin .. "_provider"] = nil
  vim.cmd("runtime " .. plugin)
end

local disabled_providers = {
  "node",
  "perl",
  "ruby",
}
for _, plugin in pairs(disabled_providers) do
  g["loaded_" .. plugin .. "_provider"] = 0
end

-- Update PATH for mason.nvim
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, "/") .. ":" .. vim.env.PATH
