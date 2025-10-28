**This is my custom configuration for neovim**

# Plugins Used

*Note: Dependencies of the plugins (if used with default options) are excluded from this list.*

1. [Nvchad/base46](https://github.com/NvChad/base46)
1. [Nvchad/ui](https://github.com/NvChad/ui)
1. [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
1. [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
1. [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
1. [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
1. [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
1. [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
1. [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim)
1. [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
1. [saghen/blink.cmp](https://github.com/saghen/blink.cmp)
1. [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
1. [Saghen/blink.pairs](https://github.com/Saghen/blink.pairs)
1. [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)
1. [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)
1. [folke/snacks.nvim](https://github.com/folke/snacks.nvim)
1. [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
1. [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
1. [folke/flash.nvim](https://github.com/folke/flash.nvim)
1. [m4xshen/hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)
1. [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
1. [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
1. [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
1. [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)
1. [OXY2DEV/markview.nvim](https://github.com/OXY2DEV/markview.nvim)
1. [kwkarlwang/bufresize.nvim](https://github.com/kwkarlwang/bufresize.nvim)
1. [5ayam5/molten-nvim](https://github.com/5ayam5/molten-nvim)
1. [GCBallesteros/jupytext.nvim](https://github.com/GCBallesteros/jupytext.nvim)
1. [5ayam5/NotebookNavigator.nvim](https://github.com/5ayam5/NotebookNavigator.nvim)

# Fresh Installation Checklist

1. `neovim >= 0.11`
1. `:MasonInstall pyright ruff clangd neocmake lua-language-server texlab` (LSPs)
1. `:MasonInstall stylua texfmt clang-format mdformat` (Formatters)
1. `:MasonInstall codelldb` (DAP)

## Jupyter setup

1. `pip install jupyter pynvim jupytext`
1. `:UpdateRemotePlugins` in the virtual/conda environment (essentially, after installing `pynvim`)

# Credits

[NvChad](https://github.com/NvChad/NvChad) and its [starter](https://github.com/NvChad/starter) repo!
