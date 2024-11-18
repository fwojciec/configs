vim.bo.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.bo.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.bo.expandtab = true -- Use spaces instead of tabs

-- Optional: Set additional settings
vim.bo.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.g.python_indent = {
	disable_parentheses_indenting = false,
	closed_paren_align_last_line = false,
	searchpair_timeout = 150,
	continue = "shiftwidth()",
	open_paren = "shiftwidth()",
	nested_paren = "shiftwidth()",
}
