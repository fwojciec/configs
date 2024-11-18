local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	"sainnhe/gruvbox-material",
	"folke/tokyonight.nvim",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-unimpaired",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-abolish",
	"vim-test/vim-test",
	"neovim/nvim-lspconfig",
	"folke/neodev.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	"nvim-lualine/lualine.nvim",
	"towolf/vim-helm",
	"lukas-reineke/indent-blankline.nvim",
	"cappyzawa/starlark.vim",
	-- "rafamadriz/friendly-snippets",
	"christianrondeau/vim-base64",
	"mhartington/formatter.nvim",
	"github/copilot.vim",
	"barreiroleo/ltex_extra.nvim",
	"romainl/Apprentice",
	"mrjosh/helm-ls",
	-- "ahmedkhalf/project.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-- require("packer").startup(function(use)
-- 	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
-- 	use("nvim-treesitter/playground")
-- 	use({
-- 		"nvim-treesitter/nvim-treesitter-textobjects",
-- 		after = "nvim-treesitter",
-- 	})
-- end)
