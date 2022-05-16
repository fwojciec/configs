local lualine = require("lualine")
local get_color = require("lualine.utils.utils").extract_highlight_colors

lualine.setup({
	options = {
		section_separators = "",
		component_separators = "¦",
		theme = "auto",
		globalstatus = true,
	},
	sections = {
		lualine_b = {
			"branch",
			{
				"diagnostics",
				symbols = { error = "𝔼", warn = "𝕎", info = "𝕀", hint = "ℍ" },
				diagnostics_color = {
					error = { fg = get_color("DiagnosticSignError", "fg") },
					warn = { fg = get_color("DiagnosticSignWarn", "fg") },
					info = { fg = get_color("DiagnosticSignInfo", "fg") },
					hint = { fg = get_color("DiagnosticSignHint", "fg") },
				},
			},
		},
		lualine_x = {
			"encoding",
			{
				"fileformat",
				icons_enabled = false,
			},
			"filetype",
		},
	},
	extensions = { "fugitive", "quickfix" },
})
