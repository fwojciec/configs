local M = {}

M.format_file = function()
  if #vim.lsp.buf_get_clients() == 0 then return end
  vim.lsp.buf.formatting_sync(nil, 1000)
end

M.organize_imports = function()
  if #vim.lsp.buf_get_clients() == 0 then return end
  local params = vim.lsp.util.make_range_params()
  params.context = { source = { organizeImports = true } } 
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if not result then return end
  result = result[1].result
  if not result then return end
  local edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
end

return M
