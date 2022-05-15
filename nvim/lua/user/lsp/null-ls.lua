local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local null_ls_utils_status_ok, null_ls_utils = pcall(require, "null-ls.utils")
if not null_ls_utils_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local group = vim.api.nvim_create_augroup("LspFormatting", {})

local format_callback = function(bufnr, async)
	vim.lsp.buf.format({
		bufnr = bufnr,
		async = async,
		filter = function(clients)
			return vim.tbl_filter(function(client)
				return client.name == "null-ls"
			end, clients)
		end,
	})
end

null_ls.setup({
	debug = false,
	debounce = 150,
	save_after_format = false,
	sources = {
		formatting.prettierd,
		formatting.shfmt,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.isort,
		formatting.goimports,
		formatting.stylua,
		formatting.terraform_fmt,
		formatting.xmllint,
		diagnostics.eslint,
		diagnostics.flake8,
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

return null_ls
