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

map("n", "<leader>o", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon toggle quick menu" })

map("n", "<M-o>", function()
  if vim.v.count == 0 then
    harpoon:list():add()
    vim.notify("Added file " .. vim.fn.expand "%:t" .. " to Harpoon", vim.log.levels.INFO, { title = "Harpoon" })
    return
  end
  harpoon:list():select(vim.v.count1)
end, { desc = "Harpoon add/goto file " })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "harpoon",
  callback = function()
    for i = 1, 9 do
      map("n", tostring(i), function()
        harpoon.ui:save()
        harpoon:list():select(i)
      end, { buffer = true, desc = "Harpoon go to file " .. i })
    end
  end,
})
