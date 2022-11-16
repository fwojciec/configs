vim.b.indent_blankline_enabled = 1

local yamlGrp = vim.api.nvim_create_augroup("GoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = yamlGrp,
  callback = function()
    require("fw.utils").run_format_cmd({ "yamlfmt", "-" })
  end
})
