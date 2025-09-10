local M = {}

M = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
}

return M
