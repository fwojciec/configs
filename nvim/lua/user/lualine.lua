local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
	return
end

local get_color = require("lualine.utils.utils").extract_highlight_colors

lualine.setup({
	options = {
		section_separators = "",
		component_separators = "",
		theme = "auto",
	},
	sections = {
		lualine_b = {
			"branch",
			{
				"diagnostics",
				symbols = { error = "𝔼", warn = "𝕎", info = "𝕀", hint = "𝕊" },
				diagnostics_color = {
					error = { fg = get_color("DiagnosticSignError", "fg") },
					warn = { fg = get_color("DiagnosticSignWarn", "fg") },
					info = { fg = get_color("DiagnosticSignInfo", "fg") },
					hint = { fg = get_color("DiagnosticSignHint", "fg") },
				},
			},
		},
		lualine_c = { "filename" },
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
