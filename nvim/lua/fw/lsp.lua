local lspconfig = require("lspconfig")

local function format_callback(bufnr, async)
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = async,
    filter = function(client)
      return require("fw.utils").includes({ "sumneko_lua", "html", "cssls", "jsonls", "denols" }, client.name)
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
  virtual_text = false,
  underline = false,
  signs = true
})

lspconfig.sumneko_lua.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "redis", "RELOAD" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
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

lspconfig.denols.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
  root_dir = lspconfig.util.root_pattern("package.json"),
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
  root_dir = lspconfig.util.root_pattern(".eslintrc"),
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

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.bufls.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  on_attach = custom_on_attach,
}
