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
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
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
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
        end,
      },

      {
        "saghen/blink.pairs",
        version = "*",
        event = "User FilePost",
        dependencies = "saghen/blink.download",
        opts = function()
          return require "configs.blink_pairs"
        end,
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
    config = function()
      require("copilot").setup(require "configs.copilot")
    end,
  },

  {
    "folke/snacks.nvim",
    dependencies = {
      "folke/todo-comments.nvim",
      "folke/flash.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUninstall", "TSLog" },
    build = ":TSUpdate",
    config = function(_, opts)
      local ensure_installed = require "configs.treesitter"
      local nvim_treesitter = require "nvim-treesitter"
      nvim_treesitter.setup(opts)
      nvim_treesitter.install(ensure_installed):await(function(err)
        if err then
          vim.notify("Failed to install TreeSitter parsers: " .. err, vim.log.levels.WARN)
          return
        end

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          pcall(vim.treesitter.start, buf)
        end
      end)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "User FilePost",
    opts = { multiwindow = true },
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
    event = "User FilePost",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_filetypes = { "harpoon", "nvdash", "nvcheatsheet", "molten_output", "snacks_terminal" },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("todo-comments").setup {}
    end,
  },

  {
    "GCBallesteros/NotebookNavigator.nvim",
    ft = "python",
    dependencies = "benlubas/molten-nvim",
  },

  {
    "benlubas/molten-nvim",
    lazy = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "snacks.nvim"
    end,
  },

  {
    "goerz/jupytext.nvim",
    lazy = false,
    opts = { format = "py:percent" },
  },

  -- TODO: make sure this is the best way to use it
  {
    "rcarriga/nvim-dap-ui",
    event = "User FilePost",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "User FilePost",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },

  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = require "configs.scrolleof",
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
    event = "User FilePost",
    config = function()
      require("markview").setup(require "configs.markview")
    end,
  },

  {
    "kwkarlwang/bufresize.nvim",
    event = { "VimResized", "WinResized" },
    config = function()
      require("bufresize").setup()
    end,
  },
}
return plugins
