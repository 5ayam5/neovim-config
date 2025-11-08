---@module "copilot"
return {
  filetypes = {
    markdown = true,
    bigfile = false,
  },
  panel = {
    auto_refresh = true,
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept_word = "<C-;>",
      accept_line = "<C-'>",
      accept = "<C-CR>",
    },
  },
}
