local cmp = require("cmp")
-- local luasnip = require("luasnip")
--

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
			-- luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
		["<C-s>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#expandable"] == 1 then
				feedkey("<Plug>(vsnip-expand)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-l>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#jumpable"](1) == 1 then
				feedkey("<Plug>(vsnip-jump-next)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
		-- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		-- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- ["<C-y>"] = cmp.config.disable,
		-- ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		-- -- Accept currently selected item. If none selected, `select` first item.
		-- -- Set `select` to `false` to only confirm explicitly selected items.
		--   ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		--     ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
		-- ["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				luasnip = "[snip]",
				buffer = "[buf]",
				path = "[path]",
			})[entry.source.name]
			return vim_item
		end,
		-- fields = { "menu", "kind", "abbr" },
	},
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
