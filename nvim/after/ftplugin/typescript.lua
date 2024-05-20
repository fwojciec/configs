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
-- Set indentation settings for TypeScript
vim.bo.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.bo.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.bo.expandtab = true -- Use spaces instead of tabs

-- Optional: Set additional settings
vim.bo.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.bo.autoindent = true -- Copy indent from current line when starting a new line
vim.bo.smartindent = true -- Insert indents automatically
