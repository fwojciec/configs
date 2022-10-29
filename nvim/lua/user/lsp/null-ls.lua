local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local group = vim.api.nvim_create_augroup("LspFormatting", {})

local format_callback = function(bufnr, async)
	vim.lsp.buf.format({
		bufnr = bufnr,
		async = async,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

null_ls.setup({
	debug = false,
	debounce = 150,
	save_after_format = false,
	sources = {
		formatting.prettierd,
		--[[ formatting.shfmt, ]]
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.isort,
		formatting.goimports,
		formatting.stylua,
		formatting.terraform_fmt,
		formatting.xmllint,
		formatting.protolint,
		--[[ formatting.pg_format, ]]
		--[[ diagnostics.eslint, ]]
		--[[ diagnostics.flake8, ]]
		-- diagnostics.buf,
		--[[ diagnostics.protolint, ]]
	},
	on_attach = function(client, bufnr)
		if not client.supports_method("textDocument/formatting") then
			return
		end

		-- execute sync format on write buffer
		vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = bufnr,
			callback = function()
				format_callback(bufnr, false)
			end,
		})

		-- define custom Fromat command that performs asnyc formatting
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
			format_callback(bufnr, true)
		end, {})

		vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { buffer = bufnr })
		vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { buffer = bufnr })
	end,
	root_dir = null_ls_utils.root_pattern(
		".null-ls-root",
		"go.mod",
		"package.json",
		"pyrightconfig.json",
		"Makefile",
		".git"
	),
})
