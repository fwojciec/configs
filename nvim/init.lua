-- plugins
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "tpope/vim-commentary"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-unimpaired"
  use "sainnhe/gruvbox-material"
  use "vim-test/vim-test"
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
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/.vimdid")
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.signcolumn = "number"
vim.opt.fixendofline = false
vim.opt.title = true
vim.opt.inccommand = "split"
vim.opt.showmode = true
vim.opt.path:append("**")
vim.opt.laststatus = 3

-- globals
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/neovim/bin/python")
vim.g.node_host_prog = vim.fn.expand("~/.nvm/versions/node/v14.17.6/bin/neovim-node-host")
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0

-- mappings
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.keymap.set("v", "Y", "y$")
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, opts)

-- colorscheme
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

-- autocommands
local yankGrp = vim.api.nvim_create_augroup("Yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 40 }) end,
  group = yankGrp,
})

local curPosGrp = vim.api.nvim_create_augroup("CursorPositionGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufRead" }, {
  pattern = "*",
  command = [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
  group = curPosGrp,
  once = true
})

-- lsp
local lspconfig = require("lspconfig")

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local function format_callback(bufnr, async)
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = async,
    filter = function(client)
      return has_value({ "sumneko_lua" }, client.name)
    end,
  })
end

local function custom_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    local fmtGrp = vim.api.nvim_create_augroup("AutoFormatGroup", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmtGrp,
      buffer = bufnr,
      callback = function()
        format_callback(bufnr, false)
      end,
    })
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false
})

lspconfig.sumneko_lua.setup {
  on_attach = custom_on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "redis" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. '/lua'] = true,
        }
      }
    }
  },

}

lspconfig.gopls.setup {
  on_attach = custom_on_attach,
  settings = {
    gopls = {
      ["build.directoryFilters"] = { "+/opt/homebrew/Cellar/go" },
      ["ui.completion.experimentalPostfixCompletions"] = true,
      ["ui.diagnostic.analyses"] = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true
      },
      ["ui.completion.usePlaceholders"] = true,
      ["ui.diagnostic.staticcheck"] = true,
      ["ui.semanticTokens"] = true,
    },
    ["go.autocompleteUnimportedPackages"] = true
  }
}
