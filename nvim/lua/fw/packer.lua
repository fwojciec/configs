require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "sainnhe/gruvbox-material"
  use "folke/tokyonight.nvim"
  use "tpope/vim-commentary"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-unimpaired"
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "vim-test/vim-test"
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    }
  }
  use "neovim/nvim-lspconfig"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/playground"
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    }
  }
  use "nvim-lualine/lualine.nvim"
  use "towolf/vim-helm"
  use "lukas-reineke/indent-blankline.nvim"
  use "cappyzawa/starlark.vim"
  use "rafamadriz/friendly-snippets"
  use "taybart/b64.nvim"
end)
