vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 40 }) end,
  group = vim.api.nvim_create_augroup("Yank", { clear = true }),
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  command = "FormatWrite"
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufRead" }, {
  pattern = "*",
  command = [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
  group = vim.api.nvim_create_augroup("CursorPositionGroup", { clear = true }),
  once = true
})
