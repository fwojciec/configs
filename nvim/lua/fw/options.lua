-- vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true -- disable when using Treesitter for indent
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/.vimdid")
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.completeopt = "menuone,noselect"
vim.o.updatetime = 250
vim.opt.signcolumn = "number"
vim.opt.titlestring = "nvim: %t"
vim.opt.title = true
vim.opt.inccommand = "split"
-- vim.opt.path:append("**")
vim.opt.laststatus = 3
