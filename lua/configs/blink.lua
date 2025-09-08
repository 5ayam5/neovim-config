local opts = {
  snippets = { preset = "luasnip" },

  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    -- ["<CR>"] = { "accept", "fallback" },
    ["<C-CR>"] = { "accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },

  completion = {
    menu = {
      draw = {
        padding = { 0, 1 },
        components = {
          kind_icon = {
            text = function(ctx)
              return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
            end,
          },
        },
      },
    },
    list = {
      selection = {
        auto_insert = false,
      },
    },
    ghost_text = {
      enabled = true,
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },

  signature = { enabled = true },

  cmdline = {
    keymap = {
      preset = 'cmdline',
    },
    completion = { menu = { auto_show = true } },
  },

  terminal = {
    enabled = true,
  },
}

return opts
