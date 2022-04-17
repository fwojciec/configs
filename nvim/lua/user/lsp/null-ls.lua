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
		diagnostics.eslint_d,
		diagnostics.flake8,
		diagnostics.tsc,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = group,
				callback = function()
					vim.lsp.buf.formatting_sync(nil, 2000)
				end,
			})
		end
	end,
	root_dir = null_ls_utils.root_pattern(".git"),
})
