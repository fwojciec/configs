local M = {}

M.setup = function()
	vim.diagnostic.config({
		virtual_text = false,
		update_in_insert = true,
		severity_sort = true,
	})
end

local telescope = require("telescope.builtin")

local function lsp_keymaps(bufnr)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
	vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr })
	vim.keymap.set("n", "gtd", telescope.lsp_type_definitions, { buffer = bufnr })
	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = bufnr })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
	vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
	vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr })
	vim.keymap.set("n", "<leader>a", telescope.diagnostics, { buffer = bufnr })
	vim.keymap.set("n", "<leader>A", telescope.diagnostics)
	vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { buffer = bufnr })
	vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
	vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { buffer = bufnr })
end

M.on_attach = function(_, bufnr)
	lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
