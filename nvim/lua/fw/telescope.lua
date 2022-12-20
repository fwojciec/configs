local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recent files" })
vim.keymap.set("n", "<leader><bs>", builtin.find_files, { desc = "[bs] Find files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find buffers" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set('n', "<leader>/", function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.load_extension("fzf")
telescope.setup({
  defaults = {
    -- path_display = { "smart" },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = false,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
})
