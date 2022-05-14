local M = {}

M.setup = function()
	vim.diagnostic.config({
		virtual_text = false,
		update_in_insert = true,
		severity_sort = true,
	})
end

local function lsp_keymaps(bufnr)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = bufnr })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
	vim.keymap.set("n", "<leader>a", vim.diagnostic.setqflist, { buffer = bufnr })
	vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { buffer = bufnr })
	vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
	vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { buffer = bufnr })

	vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end
	lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
