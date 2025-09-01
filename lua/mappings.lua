require "nvchad.mappings"

local map = vim.keymap.set

-- navigation related
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "i", "v" }, "<C-x>", "<cmd> noa w <cr>", { desc = "Save without autocmds" })

-- C++ debugging with dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", function()
        if vim.fn.filereadable('.vscode/launch.json') then
          require('dap.ext.vscode').load_launchjs(nil, { codelldb = {'c', 'cpp'} })
        end
        require('dap').continue()
      end,
  { desc = "Start or continue the debugger" })

-- notebook-navigator keybindings
map("n", "D",
  function()
    require("notebook-navigator").move_cell "d"
    vim.cmd("normal! zz")
  end,
  { desc = "Move cell down" })
map("n", "U",
  function()
    require("notebook-navigator").move_cell "u"
    vim.cmd("normal! zz")
  end,
  { desc = "Move cell up" })
map("n", "<leader>jR", "<cmd>lua require('notebook-navigator').run_cell()<cr>zz", { desc = "Run jupyter cell" })
map("n", "<leader>jr", "<cmd>lua require('notebook-navigator').run_and_move()<cr>zz", { desc = "Run and move jupyter cell" })

-- Molten keybindings
map("n", "<leader>jm", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
map("n", "<leader>je", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator", silent = true })
map("n", "<leader>js", ":noautocmd MoltenEnterOutput<CR>", { desc = "Open output window", silent = true })
map("v", "<leader>jx", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Execute visual selection", silent = true })
map("n", "<leader>jh", ":MoltenHideOutput<CR>", { desc = "Close output window", silent = true })
map("n", "<leader>ji", ":MoltenImagePopup<CR>", { desc = "Popup output image", silent = true })

-- Terminal keybindings
map("t", "<C-j><C-k>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Git
map("n", "<leader>gg",
  function()
    -- require("nvchad.term").toggle { pos = "float", id = "lazygit", cmd ='lazygit' }
    require("lazygit").lazygit()
  end,
  { desc = "Open lazygit" })
