vim.opt_local.expandtab = false
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 8

vim.keymap.set("n", "<leader>t", ":TestNearest -race<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile -race<CR>")
vim.keymap.set("n", "<leader>ts", ":TestSuite -race<CR>")
vim.keymap.set("n", "<leader>tl", ":TestLast -race<CR>")
vim.keymap.set("n", "<leader>tv", ":TestVisit -race<CR>")

vim.b.go_highlight_trailing_whitespace_error = 0
vim.b.go_highlight_string_spellcheck = 1
vim.b.go_highlight_format_strings = 1
vim.b.go_highlight_generate_tags = 1

-- local goGrp = vim.api.nvim_create_augroup("GoGroup", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = goGrp,
--   buffer = 0,
--   callback = function()
--     require("fw.utils").run_format_cmd({ "goimports", "-local", '""' })
--   end
-- })

local utils = require("fw.utils")

local function run_impl()
  local bufnr = vim.fn.bufnr()
  local lnnr = vim.api.nvim_win_get_cursor(0)[1]
  vim.ui.input({ prompt = "Impl receiver: " }, function(receiver)
    vim.ui.input({ prompt = "Impl interface: " }, function(interface)
      vim.fn.jobstart({ "impl", receiver, interface }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function(_, data)
          utils.on_job_data(data, function(processed_data)
            for _, value in ipairs(processed_data) do
              vim.notify("IMPL: " .. value, vim.log.levels.WARN)
            end
          end)
        end,
        on_stdout = function(_, data)
          utils.on_job_data(data, function(processed_data)
            vim.api.nvim_buf_set_lines(bufnr, lnnr - 1, lnnr, false, processed_data)
          end)
        end,
      })
    end)
  end)
end

vim.api.nvim_buf_create_user_command(0, "Impl", function()
  run_impl()
end, {})
