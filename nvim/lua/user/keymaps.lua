-- remap leader to space
vim.g.mapleader = " "

-- telescope
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><CR>", ":Telescope buffers<CR>", { noremap = true, silent = true })

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
