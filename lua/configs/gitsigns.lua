dofile(vim.g.base46_cache .. "git")

local map = vim.keymap.set

return {
  signs = {
    delete = { text = "󰍵" },
    changedelete = { text = "󱕖" },
  },

  on_attach = function(bufnr)
    if vim.api.nvim_buf_get_name(bufnr):match "%.ipynb$" then
      return false
    end
    map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "git toggle blame", silent = true })
    map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "git diff this", silent = true })
    map("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", { desc = "git toggle word diff", silent = true })
    map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "git stage hunk", silent = true })
    map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "git reset hunk", silent = true })
  end,
}
