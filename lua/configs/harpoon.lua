local harpoon = require "harpoon"
local map = vim.keymap.set

harpoon:setup {
  settings = {
    save_on_toggle = true,
  },
}

harpoon:extend {
  UI_CREATE = function(cx)
    map("n", "<C-v>", function()
      harpoon.ui:select_menu_item { vsplit = true }
    end, { buffer = cx.bufnr })

    map("n", "<C-h>", function()
      harpoon.ui:select_menu_item { split = true }
    end, { buffer = cx.bufnr })
  end,
}

map("n", "<leader>oo", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon open window" })

map("n", "<leader>oa", function()
  harpoon:list():add()
end, { desc = "Harpoon add current file" })
for i = 1, 9 do
  map("n", "<leader>o" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon go to file " .. i })
end
