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
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = true,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			provider = "openai",
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 4096,
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
})

-- require("packer").startup(function(use)
-- 	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
-- 	use("nvim-treesitter/playground")
-- 	use({
-- 		"nvim-treesitter/nvim-treesitter-textobjects",
-- 		after = "nvim-treesitter",
-- 	})
-- end)
