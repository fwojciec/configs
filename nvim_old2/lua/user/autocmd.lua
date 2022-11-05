local yankGrp = vim.api.nvim_create_augroup("Yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 40 })
	end,
	group = yankGrp,
})

local fileTypeGrp = vim.api.nvim_create_augroup("FileTypeCustomizations", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "requirements*.txt",
	callback = function()
		vim.opt_local.filetype = "requirements"
	end,
	group = fileTypeGrp,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = ".eslintrc",
	callback = function()
		vim.opt_local.filetype = "json"
	end,
	group = fileTypeGrp,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = ".prettierrc",
	callback = function()
		vim.opt_local.filetype = "json"
	end,
	group = fileTypeGrp,
})

local curPosGrp = vim.api.nvim_create_augroup("CursorPositionGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufRead" }, {
	pattern = "*",
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
	group = curPosGrp,
})
