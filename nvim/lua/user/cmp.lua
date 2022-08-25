local cmp = require("cmp")

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
			-- luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
		["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-e>"] = cmp.mapping.abort(),
		-- ["<C-e>"] = cmp.mapping({
		-- 	i = cmp.mapping.abort(),
		-- 	c = cmp.mapping.close(),
		-- }),
		["<C-u>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		-- ["<C-q>"] = cmp.mapping(
		-- 	cmp.mapping.confirm({
		-- 		behavior = cmp.ConfirmBehavior.Insert,
		-- 		select = false,
		-- 	}),
		-- 	{ "i", "c" }
		-- ),
		-- ["<C-Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		-- ["<C-Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				vsnip = "[snip]",
				buffer = "[buf]",
				path = "[path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	preselect = cmp.PreselectMode.None,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
				keyword_length = 5,
			},
		},
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
