-- install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

-- run sync on plugins.lua file change
vim.api.nvim_create_augroup("PackerUserConfig", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "PackerUserConfig",
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync",
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	-- general
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	-- tpope
	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-fugitive")
	use("tpope/vim-unimpaired")

	-- testing
	use("vim-test/vim-test")

	-- Colorschemes
	use("sainnhe/gruvbox-material")
	use("ellisonleao/gruvbox.nvim")

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

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- status line
	use("nvim-lualine/lualine.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
