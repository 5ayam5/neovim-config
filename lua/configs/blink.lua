dofile(vim.g.base46_cache .. "blink")

local menu = require("nvchad.blink").menu

local opts = {
  snippets = { preset = "luasnip" },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { implementation = "prefer_rust" },

  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-CR>"] = { "accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<S-Tab>"] = { "snippet_backward", "fallback_to_mappings" },
    ["<Tab>"] = { "snippet_forward", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },

    ["<C-/>"] = { "show_signature", "hide_signature", "fallback" },
  },

  completion = {
    menu = menu,
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
      auto_show_delay_ms = 200,
      window = {
        border = "single",
      },
    },
  },

  sources = {
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },

  signature = {
    enabled = true,
    window = { border = "single", show_documentation = true },
  },

  cmdline = {
    enabled = true,
    keymap = {
      ["<Tab>"] = { "show", "accept" },
      ["<Right>"] = nil,
      ["<Left>"] = nil,
      ["<C-y>"] = nil,
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
