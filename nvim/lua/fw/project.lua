require("project_nvim").setup({
	patterns = { "pyrightconfig.json", "go.mod", "Chart.yaml", "package.json", ".git", "Cargo.toml" },
	-- detection_methods = { "lsp", "pattern" },
	detection_methods = { "pattern", "lsp" },
})
