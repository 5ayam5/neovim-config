vim.api.nvim_create_user_command("LspDetachBuffer", function()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    vim.lsp.buf_detach_client(bufnr, client.id)
  end
end, {})

vim.api.nvim_create_user_command("NvimTreeGitRestart", function()
  local api = require "nvim-tree.api"
  local git_config = require("configs.nvimtree").git
  local cfg = api.config.user() or {}

  cfg.git = vim.tbl_deep_extend("force", cfg.git or {}, git_config)

  require("nvim-tree").setup(cfg)
  api.git.reload()
end, {})
