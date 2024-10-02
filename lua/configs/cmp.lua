local cmp = require("cmp")
local options = require("nvchad.configs.cmp")

options.sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "copilot" },
    }

options.mapping = {
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  ["<C-CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
  },
  ["<C-j>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif require("luasnip").expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
  ["<C-k>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
}

return options
