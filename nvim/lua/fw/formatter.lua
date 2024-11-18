require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		go = { require("formatter.filetypes.go").goimports },
		json = { require("formatter.filetypes.json").prettier },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { require("formatter.filetypes.markdown").prettier },
		proto = {
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename=file.proto" },
					stdin = true,
				}
			end,
		},
		python = { require("formatter.filetypes.python").ruff },
		sh = { require("formatter.filetypes.sh").shfmt },
		sql = { require("formatter.filetypes.sql").pgformat },
		terraform = {
			function()
				return {
					exe = "terraform",
					args = { "fmt", "-" },
					stdin = true,
				}
			end,
		},
		["terraform-vars"] = {
			function()
				return {
					exe = "terraform",
					args = { "fmt", "-" },
					stdin = true,
				}
			end,
		},
		typescript = { require("formatter.filetypes.typescript").prettier },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
		javascript = { require("formatter.filetypes.javascript").prettier },
		javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
		yaml = { require("formatter.filetypes.yaml").prettier },
		zig = { require("formatter.filetypes.zig").zigfmt },
		rust = { require("formatter.filetypes.rust").rustfmt },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
