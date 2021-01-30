require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  ident = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnr",
      scope_incremental = "gnc",
      node_decremental = "gnm",
    },
  },
}
