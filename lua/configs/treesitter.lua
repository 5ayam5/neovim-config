pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  "c",
  "cpp",
  "html",
  "html_tags",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "printf",
  "typst",
  "vim",
  "vimdoc",
  "yaml",
}
