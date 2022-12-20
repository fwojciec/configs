vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

function RELOAD(pkg)
  package.loaded[pkg] = nil
  require(pkg)
end

-- indentline
vim.g.indent_blankline_enabled = false
vim.g.indent_blankline_char = "⦙"
vim.g.indent_blankline_show_first_indent_level = false
