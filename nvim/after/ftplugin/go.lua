vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest -race<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile -race<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite -race<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast -race<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit -race<CR>", {})

vim.b.go_highlight_trailing_whitespace_error = 0
vim.b.go_highlight_string_spellcheck = 1
vim.b.go_highlight_format_strings = 1
vim.b.go_highlight_generate_tags = 1

vim.api.nvim_create_augroup("Go", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "Go",
	callback = function ()
		vim.lsp.buf.formatting_sync()
	end
})