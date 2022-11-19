local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><bs>", builtin.find_files, {})
vim.keymap.set("n", "<leader><space>", builtin.buffers, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

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
