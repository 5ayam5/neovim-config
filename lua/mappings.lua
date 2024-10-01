require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", function()
        if vim.fn.filereadable('.vscode/launch.json') then
          require('dap.ext.vscode').load_launchjs(nil, { codelldb = {'c', 'cpp'} })
        end
        require('dap').continue()
      end,
  { desc = "Start or continue the debugger" })

map("n", "]h", function()
        require("notebook-navigator").move_cell "d"
      end,
  { desc = "Move cell down" })
map("n", "[h", function()
        require("notebook-navigator").move_cell "u"
      end,
  { desc = "Move cell up" })
map("n", "<leader>jR", "<cmd>lua require('notebook-navigator').run_cell()<cr>", { desc = "Run jupyter cell" })
map("n", "<leader>jr", "<cmd>lua require('notebook-navigator').run_and_move()<cr>", { desc = "Run and move jupyter cell" })
