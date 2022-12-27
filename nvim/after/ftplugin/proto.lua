local progoGrp = vim.api.nvim_create_augroup("ProtoGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = progoGrp,
  buffer = 0,
  callback = function()
    require("fw.utils").run_format_cmd({ "clang-format", "--assume-filename=file.proto" })
  end
})
