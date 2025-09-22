local map = vim.keymap.set

-- navigation related
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<ESC>", function()
  vim.cmd "normal! \\<ESC\\>"
  vim.cmd ":noh"
end, { desc = "Search clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

map("i", "jk", "<ESC>")
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- File related
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map({ "n", "i", "v" }, "<C-x>", "<cmd> noa w <CR>", { desc = "Save without autocmds" })
map("n", "<leader>q", "<cmd> Nvdash <CR>", { desc = "Nvdash open" })
map({ "n", "x" }, "<C-f>", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- buffer related
map("n", "<leader>n", ":e ", { desc = "Open new (or existing) file" })
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-CR>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "Terminal new horizontal term" })
map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "Terminal new vertical term" })

map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Terminal toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Terminal toggleable horizontal term" })
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal toggle floating term" })

-- miscellaneous
map("n", "<leader>cc", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
map("n", "<leader>ch", ":checkhealth ", { desc = "checkhealth" })

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- C++ debugging with dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP add breakpoint at line" })
map("n", "<leader>dr", function()
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
  end
  require("dap").continue()
end, { desc = "DAP start or continue the debugger" })

-- notebook-navigator keybindings
map("n", "<leader>jd", function()
  require("notebook-navigator").move_cell "d"
end, { desc = "Notebook-Navigator move cell down" })
map("n", "<leader>ju", function()
  require("notebook-navigator").move_cell "u"
end, { desc = "Notebook-Navigator move cell up" })
map(
  "n",
  "<leader>jR",
  "<cmd>lua require('notebook-navigator').run_cell()<CR>zz",
  { desc = "Notebook-Navigator run jupyter cell" }
)
map(
  "n",
  "<leader>jr",
  "<cmd>lua require('notebook-navigator').run_and_move()<CR>zz",
  { desc = "Notebook-Navigator run and move jupyter cell" }
)

-- Molten keybindings
map("n", "<leader>jm", ":MoltenInit<CR>", { desc = "Molten initialize", silent = true })
map("n", "<leader>je", ":MoltenEvaluateOperator<CR>", { desc = "Molten evaluate operator", silent = true })
map("n", "<leader>js", ":noautocmd MoltenEnterOutput<CR>", { desc = "Molten open output window", silent = true })
map("v", "<leader>jx", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten execute visual selection", silent = true })
map("n", "<leader>jh", ":MoltenHideOutput<CR>", { desc = "Molten close output window", silent = true })
map("n", "<leader>ji", ":MoltenImagePopup<CR>", { desc = "Molten popup output image", silent = true })

--@TODO: move this to a separate file
-- Harpoon
local harpoon = require "harpoon"
harpoon:setup {
  settings = {
    save_on_toggle = true,
  },
}
harpoon:extend {
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item { vsplit = true }
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-h>", function()
      harpoon.ui:select_menu_item { split = true }
    end, { buffer = cx.bufnr })
  end,
}
map("n", "<leader>oo", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon open window" })
vim.keymap.set("n", "<leader>oa", function()
  harpoon:list():add()
end, { desc = "Harpoon add current file" })
for i = 1, 9 do
  vim.keymap.set("n", "<leader>o" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon go to file " .. i })
end

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>m",
      ":RenderMarkdown toggle<CR>",
      { desc = "Toggle Markdown rendering", buffer = true }
    )
  end,
})
