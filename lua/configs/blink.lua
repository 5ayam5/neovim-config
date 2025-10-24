dofile(vim.g.base46_cache .. "blink")

local lspkindicons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󱓻",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  Supermaven = "",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
  BladeNav = "",
}

local menu = {
  scrollbar = false,
  draw = {
    padding = { 0, 1 },
    columns = { { "kind_icon" }, { "label" }, { "kind" } },
    components = {
      kind_icon = {
        text = function(ctx)
          local icons = lspkindicons
          local icon = " " .. (icons[ctx.kind] or "󰈚") .. " "
          return icon
        end,
      },

      kind = { highlight = "comment" },
    },
  },
}

local opts = {
  snippets = { preset = "luasnip" },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { implementation = "prefer_rust" },

  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-CR>"] = { "accept", "fallback" },

    ["<C-p>"] = { "select_prev", "snippet_backward", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "snippet_forward", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },

    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
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
    },
  },

  sources = {
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },

  signature = {
    enabled = true,
    window = { scrollbar = true, show_documentation = true },
  },

  cmdline = {
    enabled = true,
    keymap = {
      ["<Tab>"] = { "show", "accept" },
      ["<Right>"] = false,
      ["<Left>"] = false,
      ["<C-y>"] = false,
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
