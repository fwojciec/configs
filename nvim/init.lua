-- plugins
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "sainnhe/gruvbox-material"
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
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/nvim-cmp"
  use "neovim/nvim-lspconfig"
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
vim.g.mapleader = ","
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, { noremap = true, silent = true })

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

-- colorscheme
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

-- luasnip
local ls = require "luasnip"
ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = nil,
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- cmp
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require 'luasnip'.lsp_expand(args.body)
      -- vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        vsnip = "[snip]",
        buffer = "[buf]",
        path = "[path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 1024 * 1024 then -- 1 Megabyte max
            return {}
          end
          return { buf }
        end,
        keyword_length = 5,
      },
    },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  },
})

-- lsp
local lspconfig = require("lspconfig")

local function format_callback(bufnr, async)
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = async,
    filter = function(client)
      return require("fw.utils").includes({ "sumneko_lua", "html", "cssls", "jsonls" }, client.name)
    end,
  })
end

local function custom_on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false
})

lspconfig.sumneko_lua.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
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
  capabilities = capabilities,
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

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  settings = {
    eslint = {
      format = {
        enable = false
      }
    }
  },
  on_attach = custom_on_attach,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}
