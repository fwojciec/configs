-- remap leader to space
vim.g.mapleader = " "

-- telescope
local telescope_builtin = require("telescope.builtin")
local telescope_user = require("user.telescope")
vim.keymap.set("n", "<leader><leader>", function()
	telescope_user.project_files()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ff", function()
	telescope_user.project_files()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader><CR>", function()
	telescope_builtin.buffers()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fb", function()
	telescope_builtin.buffers()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fb", function()
	telescope_builtin.buffers()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fd", function()
	telescope_builtin.diagnostics()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fh", function()
	telescope_builtin.help_tags()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fg", function()
	telescope_builtin.live_grep()
end, { noremap = true, silent = true })

-- editing
vim.keymap.set("v", "p", '"_dP', { noremap = true })
vim.keymap.set("v", "Y", "y$", { noremap = true })

-- navigation
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })

-- vim test
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", {})
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", {})

-- treesitter fix
vim.keymap.set("n", "<leader>we", ":write | edit | TSBufEnable highlight<CR>", { noremap = true, silent = true })
