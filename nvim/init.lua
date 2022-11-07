-- plugins
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use { "sainnhe/gruvbox-material", config = require("fw.gruvbox").config() }
  use "tpope/vim-commentary"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-unimpaired"
  use "vim-test/vim-test"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-vsnip"
  use { "hrsh7th/vim-vsnip", config = require("fw.vsnip").config() }
  use { "hrsh7th/nvim-cmp", config = require("fw.cmp").config() }
  use { "neovim/nvim-lspconfig", config = require("fw.lsp").config() }
end)

-- options
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/.vimdid")
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.signcolumn = "number"
vim.opt.title = true
vim.opt.inccommand = "split"
vim.opt.path:append("**")
vim.opt.laststatus = 3

-- globals
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- mappings
vim.g.mapleader = " "
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, opts)

-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 40 }) end,
  group = vim.api.nvim_create_augroup("Yank", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufRead" }, {
  pattern = "*",
  command = [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
  group = vim.api.nvim_create_augroup("CursorPositionGroup", { clear = true }),
  once = true
})
