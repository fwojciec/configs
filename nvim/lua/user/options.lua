local utils = require("user.utils")

vim.opt.guicursor = {}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = utils.home_path(".local/share/nvim/.vimdid")
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append({ c = true, I = true })
vim.opt.signcolumn = "number"
vim.opt.mouse = "a"
vim.opt.emoji = false
vim.opt.fixendofline = false
vim.opt.title = true
vim.opt.formatoptions:remove("t")
vim.opt.inccommand = "split"
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.laststatus = 3
