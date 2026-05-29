return {
  panel = {
    auto_refresh = true,
  },
  virtualtext = {
    auto_trigger_ft = { "*" },
    auto_trigger_ignore_ft = {
      "markdown",
      "codecompanion",
      "bigfile",
    },
    keymap = {
      accept_line = "<C-'>",
      accept = "<C-CR>",
    },
    show_on_completion_menu = true,
  },
  provider = "gemini",
  provider_options = {
    gemini = {
      model = "gemini-3.1-flash-lite",
    },
  },
  throttle = 2000,
}
