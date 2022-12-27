vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("MarkdownGroup", { clear = true }),
  buffer = 0,
  callback = function()
    require("fw.utils").run_format_cmd({ "prettier", "--stdin-filepath", "<afile>" })
  end
})
