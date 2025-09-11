local opts = {
  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },

    -- @FIXME: uncomment this once
    --  https://github.com/Saghen/blink.cmp/commit/b7e240484affbb62eebb8604ea3d63f88d320f12
    --  is added to stable
    -- ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
    -- ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
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
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded",
      },
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

  signature = {
    enabled = true,
    window = { scrollbar = true, border = "rounded", show_documentation = true },
  },

  cmdline = {
    keymap = {
      ["<Tab>"] = { "show", "accept" },
    },
    completion = {
      menu = {
        auto_show = function(_)
          return vim.fn.getcmdtype() == ":" or vim.fn.getcmdtype() == "@"
        end,
      },
    },
  },
}

return opts
