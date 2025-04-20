-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
	},
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				menu = { border = "single" },
				documentation = { window = { border = "single" }, auto_show = false },
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", config = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
	},

	{
		"sainnhe/gruvbox-material",
		priority = 1000,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Already listed above, lazy.nvim handles it
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	{ "tpope/vim-commentary", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "tpope/vim-fugitive", cmd = { "Git", "G" } },
	{ "tpope/vim-rhubarb", dependencies = { "tpope/vim-fugitive" }, event = "VeryLazy" },
	{ "tpope/vim-abolish", cmd = { "Abolish", "Subvert" }, event = "VeryLazy" },

	{ "vim-test/vim-test", cmd = { "TestNearest", "TestFile", "TestSuite" } },
	{
		"mhartington/formatter.nvim",
		event = "BufWritePre",
	},
	{ "github/copilot.vim", event = "VeryLazy" },
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion" },
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},

	{ "towolf/vim-helm", ft = "helm" },
	{ "cappyzawa/starlark.vim", ft = "starlark" },
	{ "barreiroleo/ltex_extra.nvim", ft = { "markdown", "tex", "plaintex" } },
})
