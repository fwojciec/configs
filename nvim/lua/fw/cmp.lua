local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[lsp]",
				codecompanion = "[cc]",
				path = "[path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	preselect = cmp.PreselectMode.None,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "codecompanion" },
	},
})
