local plugins = {
  "nvim-lua/plenary.nvim",

  {
    "nvchad/base46",
    priority = 100,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return {}
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = require("configs.indent_blankline").opts,
    config = require("configs.indent_blankline").config,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function()
      return require "configs.conform"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = "jupy",
    event = "User FilePost",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = { history = true, update_events = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
        end,
      },

      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "snacks_picker_input", "vim", "bigfile" },
        },
      },

      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
    opts = function()
      return require "configs.blink"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return require "configs.copilot"
    end,
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return require("configs.snacks").opts
    end,
    keys = function()
      return require("configs.snacks").keys
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    priority = 60,
    build = ":TSUpdate",
    config = function(_, opts)
      local ensure_installed = require "configs.treesitter"
      local nvim_treesitter = require "nvim-treesitter"
      nvim_treesitter.setup(opts)
      nvim_treesitter.install(ensure_installed)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "User FilePost",
    opts = {
      multiwindow = true,
      max_lines = 5,
      multiline_threshold = 1,
      on_attach = function(buf)
        if vim.bo[buf].filetype == "bigfile" then
          return false
        end
        return true
      end,
    },
  },

  {
    "folke/flash.nvim",
    event = "User FilePost",
    opts = function()
      return require("configs.flash").opts
    end,
    keys = function()
      return require("configs.flash").keys
    end,
  },

  -- NOTE: remove this once I become proficient
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_filetypes = {
        "harpoon",
        "nvdash",
        "nvcheatsheet",
        "molten_output",
        "snacks_terminal",
        "snacks_notif_history",
        "bigfile",
      },
      restriction_mode = "hint",
      restricted_keys = {
        ["<C-N>"] = {},
        ["<C-P>"] = {},
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "todo")
      return {}
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    keys = {
      {
        "<leader>di",
        function() end,
        desc = "DAP initialize UI",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dapui"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "configs.harpoon"
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    priority = 75,
    opts = function()
      return require "configs.markview"
    end,
  },

  {
    "kwkarlwang/bufresize.nvim",
    event = { "VimResized", "WinResized" },
    opts = {},
  },

  {
    "f3fora/nvim-texlabconfig",
    ft = { "tex", "bib" },
    opts = {},
    build = "go build",
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "User FilePost",
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "auto:1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },

  {
    "luukvbaal/statuscol.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-ufo",
    },
    event = "User FilePost",
    opts = function()
      return require "configs.statuscol"
    end,
  },

  {
    dev = true,
    "molten-nvim",
    build = ":UpdateRemotePlugins",
    lazy = false,
    init = function()
      local g = vim.g
      g.molten_wrap_output = true
      g.molten_output_show_more = true
      g.molten_cover_empty_lines = true

      g.molten_virt_text_output = true
      g.molten_virt_text_truncate = "top"

      g.molten_auto_open_output = false
      g.molten_enter_output_behavior = "open_and_enter"
      g.molten_output_win_cover_gutter = false
      g.molten_output_win_style = "minimal"

      g.molten_image_location = "both"
      g.molten_image_provider = "snacks.nvim"
    end,
  },

  {
    dev = true,
    "jupytext.nvim",
    lazy = false,
    opts = { style = "percent", force_ft = "jupy" },
  },

  {
    dev = true,
    "NotebookNavigator.nvim",
    ft = "jupy",
    dependencies = "5ayam5/molten-nvim",
    opts = {
      cell_markers = {
        jupy = "# %%",
      },
      syntax_highlight = true,
    },
  },
}
return plugins
