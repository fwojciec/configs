local function nnoremap(lhs, rhs, buffer)
  vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = buffer })
end

local function xnoremap(lhs, rhs, buffer)
  vim.keymap.set("x", lhs, rhs, { noremap = true, silent = true, buffer = buffer })
end

vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-j>", "<Down>")
nnoremap("<leader>w", "<cmd>w<cr>")
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<leader>d", vim.diagnostic.open_float)
nnoremap("<leader>D", vim.diagnostic.setloclist)
nnoremap("<leader>s", "<cmd>so %<cr>")
xnoremap("<leader>p", "\"_dP")

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
