-- remap leader to space
vim.g.mapleader = " "

-- telescope
local telescope_builtin = require("telescope.builtin")
local telescope_user = require("user.telescope")
vim.keymap.set("n", "<leader><leader>", function()
	telescope_user.project_files()
end)

vim.keymap.set("n", "<leader>ff", function()
	telescope_user.project_files()
end)

vim.keymap.set("n", "<leader><CR>", function()
	telescope_builtin.buffers()
end)

vim.keymap.set("n", "<leader>fb", function()
	telescope_builtin.buffers()
end)

vim.keymap.set("n", "<leader>fb", function()
	telescope_builtin.buffers()
end)

vim.keymap.set("n", "<leader>fd", function()
	telescope_builtin.diagnostics()
end)

vim.keymap.set("n", "<leader>fh", function()
	telescope_builtin.help_tags()
end)

vim.keymap.set("n", "<leader>fg", function()
	telescope_builtin.live_grep()
end)

-- editing
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "Y", "y$")

-- navigation
vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-j>", "<Down>")

-- vim test
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>")

-- treesitter fix
vim.keymap.set("n", "<leader>we", ":write | edit | TSBufEnable highlight<CR>")

-- lsp restart
vim.keymap.set("n", "<leader>r", ":write | vim.lsp.stop_client(vim.lsp.get_active_clients()) | edit")
