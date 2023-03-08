require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
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
		typescript = { require("formatter.filetypes.typescript").prettierd },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
		yaml = { require("formatter.filetypes.yaml").prettierd },
		zig = { require("formatter.filetypes.zig").zigfmt },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
