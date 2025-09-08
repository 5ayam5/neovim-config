require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both"
o.whichwrap = "<>[],b,s"
o.relativenumber = true

local enable_providers = {
  "python3",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin .. "_provider"] = nil
  vim.cmd("runtime " .. plugin)
end

vim.g.tex_flavor = "latex"
vim.g.zz_mode = "zz"
