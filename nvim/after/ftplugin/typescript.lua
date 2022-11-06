local function format_callback()
  local bufnr = vim.fn.bufnr()
  local win = vim.api.nvim_get_current_win()
  local old_pos = vim.api.nvim_win_get_cursor(win)
  local file_name = vim.api.nvim_buf_get_name(bufnr)

  local job = vim.fn.jobstart({ "prettier", "--stdin-filepath", file_name }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data[#data] ~= "" then
        error("eof expected", 2)
      end
      table.remove(data)
      if data[1] == nil then
        -- prettier error, likely syntax error on save
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
    end,
  })
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.fn.chansend(job, lines)
  vim.fn.chanclose(job, "stdin")
  vim.fn.jobwait({ job }, 1000)
  vim.api.nvim_win_set_cursor(0, require("fw.utils").safe_pos(bufnr, old_pos))
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TypeScriptGroup", { clear = true }),
  callback = format_callback
})
