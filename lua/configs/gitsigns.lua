dofile(vim.g.base46_cache .. "git")

return {
  signs = {
    delete = { text = "󰍵" },
    changedelete = { text = "󱕖" },
  },

  on_attach = function(bufnr)
    if vim.api.nvim_buf_get_name(bufnr):match "%.ipynb$" then
      return false
    end
  end,
}
