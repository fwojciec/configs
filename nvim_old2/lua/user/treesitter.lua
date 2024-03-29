local configs = require("nvim-treesitter.configs")
configs.setup({
	sync_install = false,
	ignore_install = { "" },
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = false, disable = {} },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
