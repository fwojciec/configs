vim.b.indent_blankline_enabled = 1

local yamlGrp = vim.api.nvim_create_augroup("GoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = yamlGrp,
  buffer = 0,
  callback = function(opts)
    vim.pretty_print(vim.bo[opts.buf].filetype)
    require("fw.utils").run_format_cmd({ "yamlfmt", "-" })
  end
})
