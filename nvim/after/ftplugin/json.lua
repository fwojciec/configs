vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("JsonGroup", { clear = true }),
  callback = function()
    local bufnr = vim.fn.bufnr()
    local file_name = vim.api.nvim_buf_get_name(bufnr)
    require("fw.utils").run_format_cmd({ "prettier", "--stdin-filepath", file_name })
  end
})
