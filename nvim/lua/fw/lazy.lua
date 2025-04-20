-- Bootstrap lazy.nvim
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
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
		},
	},

	-- == LSP ==
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", config = true },
		},
		config = function()
			-- LSP setup goes here (attach servers, keymaps)
			-- Example: require('lspconfig').gopls.setup{}
		end,
	},

	-- == UI / UX ==
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy", -- Load after startup
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for icons
		opts = {
			-- Lualine options go here
			-- options = { theme = 'auto' }, -- Example
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- Load early for visual consistency
		main = "ibl", -- Specify the main module for better lazy-loading
		opts = {
			-- Indent-blankline options
			-- scope = { enabled = false }, -- Example
		},
	},
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "codecompanion" }, -- Load only for markdown or codecompanion buffers
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure Treesitter is loaded
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion" }, -- Redundant due to `ft` trigger, but harmless
				ignore_buftypes = {},
			},
			-- Add other markview options if needed
		},
	},

	-- == Themes == (Load early, set priority)
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function() --[[ vim.cmd.colorscheme "gruvbox-material" ]]
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function() --[[ vim.cmd.colorscheme "tokyonight" ]]
		end,
	},
	{
		"romainl/Apprentice",
		priority = 1000,
		config = function() --[[ vim.cmd.colorscheme "apprentice" ]]
		end,
	},
	-- Add a line here after lazy.setup to set your desired colorscheme, e.g.:
	-- vim.cmd.colorscheme "tokyonight"

	-- == Telescope ==
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope", -- Load when :Telescope is called
		dependencies = {
			"nvim-lua/plenary.nvim", -- Already listed above, lazy.nvim handles it
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			-- Telescope setup and keymaps go here
			-- Example: require('telescope').setup { ... }
		end,
	},

	-- == Tim Pope Classics (Generally load on demand) ==
	{ "tpope/vim-commentary", event = "VeryLazy" }, -- Or use `keys` if you map `gc` etc.
	{ "tpope/vim-surround", event = "VeryLazy" }, -- Needs setup or keymaps to trigger loading if using `keys`
	{ "tpope/vim-repeat", event = "VeryLazy" }, -- Often used with surround/commentary
	{ "tpope/vim-unimpaired", event = "VeryLazy" }, -- Or use `keys` for its mappings
	{ "tpope/vim-fugitive", cmd = { "Git", "G" } }, -- Load on Git commands
	{ "tpope/vim-rhubarb", dependencies = { "tpope/vim-fugitive" }, event = "VeryLazy" }, -- Enhances fugitive
	{ "tpope/vim-abolish", cmd = { "Abolish", "Subvert" }, event = "VeryLazy" }, -- Load on commands or lazily

	-- == Development / Utility ==
	{ "vim-test/vim-test", cmd = { "TestNearest", "TestFile", "TestSuite" } }, -- Load on test commands
	{
		"mhartington/formatter.nvim",
		event = "BufWritePre", -- Example: Load when saving a buffer to format
		-- Or use cmd = "Format" if you format manually
		config = function()
			-- Formatter setup goes here
			-- Example: require('formatter').setup { ... }
		end,
	},
	{ "christianrondeau/vim-base64", cmd = { "Base64Encode", "Base64Decode" } }, -- Load on command

	-- == AI / Assistance ==
	{ "github/copilot.vim", event = "VeryLazy" }, -- Load after startup
	{
		"olimorris/codecompanion.nvim",
		-- Using the specific branch as in original config
		branch = "feat/move-to-function-calling",
		cmd = { "CodeCompanion" }, -- Load when CodeCompanion command is used
		-- Dependencies are implicitly handled by lazy.nvim (plenary, treesitter)
		-- Explicitly listing them is fine too if needed for clarity or specific dep config
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {}, -- Keep existing opts
		-- config = function() ... end -- Add config if needed
	},

	-- == Language Specific ==
	{ "towolf/vim-helm", ft = "helm" }, -- Load for Helm files
	{ "cappyzawa/starlark.vim", ft = "starlark" }, -- Load for Starlark files
	{ "mrjosh/helm-ls", ft = "helm" }, -- Load for Helm files (likely related to LSP/helm)
	{ "barreiroleo/ltex_extra.nvim", ft = { "markdown", "tex", "plaintex" } }, -- Load for text/markup files

	-- == Commented Out / Unused ==
	-- "rafamadriz/friendly-snippets", -- Now potentially a dependency of LuaSnip
	-- "ahmedkhalf/project.nvim",
})

-- Set your preferred colorscheme AFTER lazy setup
-- This ensures the theme plugin has been loaded (due to priority=1000)
-- vim.cmd.colorscheme "tokyonight" -- Example, uncomment and choose one
