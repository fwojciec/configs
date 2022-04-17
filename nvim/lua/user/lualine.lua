local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = false,
		section_separators = "",
		component_separators = "",
		theme = "gruvbox-material",
	},
})
