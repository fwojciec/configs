require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		go = { require("formatter.filetypes.go").goimports },
		json = { require("formatter.filetypes.json").prettierd },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { require("formatter.filetypes.markdown").prettierd },
		proto = {
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename=file.proto" },
					stdin = true,
				}
			end,
		},
		typescript = { require("formatter.filetypes.typescript").prettierd },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
		yaml = { require("formatter.filetypes.yamls").prettierd },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
