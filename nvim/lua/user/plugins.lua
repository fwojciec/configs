-- run sync on plugins.lua file change
vim.api.nvim_create_augroup("PackerUserConfig", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "PackerUserConfig",
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync",
})

local packer = require("packer")
return packer.startup(function(use)
	-- general
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	-- tpope
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-fugitive")
	use("tpope/vim-unimpaired")

	-- comments
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- testing
	use("vim-test/vim-test")

	-- Colorschemes
	use("sainnhe/gruvbox-material")
	-- use("ellisonleao/gruvbox.nvim")
	-- use("marko-cerovac/material.nvim")
	-- use("bluz71/vim-nightfly-guicolors")
	-- use("bluz71/vim-moonfly-colors")
	-- use("kvrohit/substrata.nvim")

	-- snippets
	use("L3MON4D3/LuaSnip")

	-- cmp plugins
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("saadparwaiz1/cmp_luasnip")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")
	use("b0o/schemastore.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- status line
	use("nvim-lualine/lualine.nvim")
end)
