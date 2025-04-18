require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

local enable_providers = {
  "python3",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin .. "_provider"] = nil
  vim.cmd("runtime " .. plugin)
end
