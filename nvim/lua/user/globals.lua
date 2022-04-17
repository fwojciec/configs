local HOME = os.getenv("HOME")
vim.g.python3_host_prog = HOME .. "/.pyenv/versions/neovim/bin/python"
vim.g.node_host_prog = HOME .. "/.nvm/versions/node/v14.17.6/bin/neovim-node-host"
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0

-- indentline
vim.g.indent_blankline_enabled = false
vim.g.indent_blankline_char = "⦙"
vim.g.indent_blankline_show_first_indent_level = false
