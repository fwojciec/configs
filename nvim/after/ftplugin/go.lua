vim.opt_local.expandtab = false
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 8

vim.keymap.set("n", "<leader>t", ":TestNearest -race<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile -race<CR>")
vim.keymap.set("n", "<leader>ts", ":TestSuite -race<CR>")
vim.keymap.set("n", "<leader>tl", ":TestLast -race<CR>")
vim.keymap.set("n", "<leader>tv", ":TestVisit -race<CR>")

vim.b.go_highlight_trailing_whitespace_error = 0
vim.b.go_highlight_string_spellcheck = 1
vim.b.go_highlight_format_strings = 1
vim.b.go_highlight_generate_tags = 1

local function format_callback()
  local bufnr = vim.fn.bufnr()
  local winnr = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(winnr)
  vim.cmd('silent %! goimports -local ""')
  vim.api.nvim_win_set_cursor(winnr, require("fw.utils").safe_pos(bufnr, pos))
end

local goGrp = vim.api.nvim_create_augroup("GoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = goGrp,
  callback = format_callback
})
