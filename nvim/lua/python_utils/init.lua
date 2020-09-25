local M = {}

M.format_on_save = function(timeout_ms)
  local cur = vim.fn.winsaveview()
  if pcall(vim.cmd, 'undojoin') then
  else
  end
  vim.lsp.buf.formatting_sync(nil, timeout_ms)
  vim.fn.winrestview(cur)
end

return M
