-- local is_ts = vim.fn.glob("./deno.json*") == ""

-- if is_ts then
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     group = vim.api.nvim_create_augroup("TypeScriptGroup", { clear = true }),
--     buffer = 0,
--     callback = function()
--       local bufnr = vim.fn.bufnr()
--       local file_name = vim.api.nvim_buf_get_name(bufnr)
--       require("fw.utils").run_format_cmd({ "prettier", "--stdin-filepath", file_name })
--     end
--   })
-- end
