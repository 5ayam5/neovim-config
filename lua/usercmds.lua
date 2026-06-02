vim.api.nvim_create_user_command("LspDetachBuffer", function()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    vim.lsp.buf_detach_client(bufnr, client.id)
  end
end, {})
