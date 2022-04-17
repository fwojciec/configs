-- remap leader to space
vim.g.mapleader = ' '

-- telescope
vim.api.nvim_set_keymap("n", "<leader><leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><CR>", ":Telescope buffers<CR>", { noremap = true, silent = true })

-- editing
vim.api.nvim_set_keymap("v", "p", "\"_dP", { noremap = true })
vim.api.nvim_set_keymap("v", "Y", "y$", { noremap = true })

-- navigation
vim.api.nvim_set_keymap("c", "<C-k>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-j>", "<Down>", { noremap = true })

-- vim test
vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", {})
