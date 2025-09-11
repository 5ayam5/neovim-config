require "nvchad.mappings"

local map = vim.keymap.set

-- navigation related
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<ESC>", function ()
  vim.cmd "normal! \\<ESC\\>"
  vim.cmd ":noh"
end)

-- File related
map({ "n", "i", "v" }, "<C-x>", "<cmd> noa w <cr>", { desc = "Save without autocmds" })

-- C++ debugging with dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP add breakpoint at line" })
map("n", "<leader>dr", function()
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
  end
  require("dap").continue()
end, { desc = "DAP start or continue the debugger" })

-- notebook-navigator keybindings
map("n", "D", function()
  require("notebook-navigator").move_cell "d"
end, { desc = "Notebook-Navigator move cell down" })
map("n", "U", function()
  require("notebook-navigator").move_cell "u"
end, { desc = "Notebook-Navigator move cell up" })
map(
  "n",
  "<leader>jR",
  "<cmd>lua require('notebook-navigator').run_cell()<cr>zz",
  { desc = "Notebook-Navigator run jupyter cell" }
)
map(
  "n",
  "<leader>jr",
  "<cmd>lua require('notebook-navigator').run_and_move()<cr>zz",
  { desc = "Notebook-Navigator run and move jupyter cell" }
)

-- Molten keybindings
map("n", "<leader>jm", ":MoltenInit<CR>", { desc = "Molten initialize", silent = true })
map("n", "<leader>je", ":MoltenEvaluateOperator<CR>", { desc = "Molten evaluate operator", silent = true })
map("n", "<leader>js", ":noautocmd MoltenEnterOutput<CR>", { desc = "Molten open output window", silent = true })
map("v", "<leader>jx", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten execute visual selection", silent = true })
map("n", "<leader>jh", ":MoltenHideOutput<CR>", { desc = "Molten close output window", silent = true })
map("n", "<leader>ji", ":MoltenImagePopup<CR>", { desc = "Molten popup output image", silent = true })

-- Git
map("n", "<leader>gg", function()
  require("lazygit").lazygit()
end, { desc = "Lazygit open lazygit" })
