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

M.run_format_cmd = function(command)
  local bufnr = vim.fn.bufnr()
  local win = vim.api.nvim_get_current_win()
  local old_pos = vim.api.nvim_win_get_cursor(win)

  local job = vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data[#data] == "" then
        table.remove(data)
      end
      if data[1] == nil then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
    end,
  })

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.fn.chansend(job, lines)
  vim.fn.chanclose(job, "stdin")
  vim.fn.jobwait({ job }, 1000)
  vim.api.nvim_win_set_cursor(0, M.safe_pos(bufnr, old_pos))
end

M.on_job_data = function(data, callback)
  if data[#data] ~= "" then
    error("eof expected", 2)
  end
  table.remove(data)
  if data[1] == nil then
    return
  end
  callback(data)
end

return M
