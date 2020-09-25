local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')
-- local completion = require('completion')
local diagnostic = require('diagnostic')

local M = {}

M.mapper = function(mode, key, result)
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

M.define_disgnostic_signs = function()
  vim.fn.sign_define('LspDiagnosticsErrorSign', {text = '->', texthl = 'LspDiagnosticsError'})
  vim.fn.sign_define('LspDiagnosticsWarningSign', {text = '->', texthl = 'LspDiagnosticsWarning'})
  vim.fn.sign_define('LspDiagnosticsInformationSign', {text = '->', texthl = 'LspDiagnosticsInformation'})
  vim.fn.sign_define('LspDiagnosticsHintSign', {text = '->', texthl = 'LspDiagnosticsHint'})
end

M.on_attach = function(client, bufnr)
  lsp_status.register_progress()

  lsp_status.config{
    status_symbol = 'LSP',
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'I',
    indicator_hint = 'H',
    indicator_ok = '✔️',
    spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
  }

  -- completion.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)

  M.mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  M.mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  M.mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  M.mapper('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  M.mapper('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  M.mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  M.mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  M.mapper('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  M.mapper('n', ']g', '<cmd>NextDiagnosticCycle<CR>')
  M.mapper('n', '[g', '<cmd>PrevDiagnosticCycle<CR>')
  M.mapper('n', '<leader>rr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>')

  vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
  M.define_disgnostic_signs()
end

nvim_lsp.gopls.setup{
  -- cmd = { 'gopls', '-remote=auto' },
  on_attach = function(client, bufnr)
    M.on_attach(client, bufnr)
    vim.api.nvim_command('au BufWritePre *.go lua require"go_utils".organize_imports_sync(1000)')
  end,
  capabilities = lsp_status.capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    deepCompletion = true,
    linksInHover = false,
  },
}

nvim_lsp.vimls.setup({
  on_attach = M.on_attach,
  capabilities = lsp_status.capabilities
})

nvim_lsp.jsonls.setup({
  on_attach = M.on_attach,
  capabilities = lsp_status.capabilities
})

nvim_lsp.yamlls.setup{
  on_attach = M.on_attach,
  capabilities = lsp_status.capabilities
}

nvim_lsp.pyls.setup{
  enable = true,
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false,
    },
  },
  on_attach = function(client, bufnr)
    M.on_attach(client, bufnr)
    vim.api.nvim_command('au BufWritePre *.py lua require"python_utils".format_on_save(1000)')
  end,
  capabilities = lsp_status.capabilities,
}

-- nvim_lsp.pyls_ms.setup{
--   on_attach = function(client, bufnr)
--     lsp_status.register_progress()

--     lsp_status.config{
--       status_symbol = 'LSP',
--       indicator_errors = 'E',
--       indicator_warnings = 'W',
--       indicator_info = 'I',
--       indicator_hint = 'H',
--       indicator_ok = '✔️',
--       spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
--     }

--     completion.on_attach(client, bufnr)
--     -- diagnostic.on_attach(client, bufnr)
--     lsp_status.on_attach(client, bufnr)

--     M.mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
--     M.mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
--     M.mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
--     M.mapper('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
--     M.mapper('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
--     M.mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--     M.mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
--     M.mapper('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
--     M.mapper('n', ']g', '<cmd>NextDiagnosticCycle<CR>')
--     M.mapper('n', '[g', '<cmd>PrevDiagnosticCycle<CR>')
--     M.mapper('n', '<leader>rr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>')
--   end,
--   init_options = {
--     analysisUpdates = true,
--     asyncStartup = false,
--     displayOptions = {},
--     interpreter = {
--       properties = {
--         InterpreterPath = '/Users/filip/.pyenv/versions/virtualo_api/bin/python',
--         Version = '2.7'
--       }
--     }
--   },
--   settings = {
--     python = {
--       autoComplete = {
--         extraPaths = {
--           './python',
--           '/Users/filip/.pyenv/versions/virtualo_api/lib/python2.7',
--           '/Users/filip/.pyenv/versions/virtualo_api/lib/python2.7/lib-dynload',
--           '/Users/filip/.pyenv/versions/virtualo_api/lib/python2.7/site-packages',
--         },
--       }
--     }
--   }
-- }

-- nvim_lsp.sumneko_lua.setup{
--   on_attach = on_attach_vim,
--   settings = {
--     Lua = {
--       runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
--       diagnostics = { enable = true, globals = { 'vim' } },
--       completion = { keywordSnippet = 'Disable' },
--       workspace = {
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--         },
--       },
--     },
--   },
-- }

-- nvim_lsp.diagnosticls.setup{
--   on_attach = on_attach_vim,
--   capabilities = lsp_status.capabilities,
--   callbacks = {
--     ["textDocument/rename"] = function() end,
--     ["textDocument/hover"] = function() end,
--     ["textDocument/documentSymbol"] = function() end,
--   },
--   filetypes = {'go'},
--   init_options = {
--     filetypes = {
--       go = {'golangcilint'},
--     },
--     linters = {
--       golangcilint = {
--         command = 'golangci-lint',
--         rootPatterns = {'.git', 'go.mod'},
--         debounce = 100,
--         args = {'run', '--out-format', 'json', '--config', '~/.golangci.yml'},
--         sourceName = 'golangci-lint',
--         parseJson = {
--           sourceName = 'Pos.Filename',
--           sourceNameFilter = true,
--           errorsRoot = 'Issues',
--           line = 'Pos.Line',
--           column = 'Pos.Column',
--           message = '${Text} [${FromLinter}]',
--           security = 'Severity',
--         },
--         securities = {
--           error = 'error',
--           warning = 'warning',
--           note = 'info',
--         },
--       },
--     },
--   },
-- }
--
