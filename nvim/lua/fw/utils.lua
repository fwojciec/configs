local M = {}

M.feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, false)
end

M.includes = function(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

M.safe_pos = function(bufnr, pos)
  local o_row, o_col = unpack(pos)

  local max_row = vim.api.nvim_buf_line_count(0)
  local row = o_row
  if o_row > max_row then
    row = max_row
  end

  local max_col = string.len(unpack(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)))
  local col = o_col
  if o_col > max_col then
    col = max_col
  end

  return { row, col }
end

return M
