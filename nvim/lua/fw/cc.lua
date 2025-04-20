require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "openai",
		},
		inline = {
			adapter = "openai",
		},
		cmd = {
			adapter = "openai",
		},
	},
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				schema = {
					model = {
						default = "o4-mini",
					},
				},
			})
		end,
	},
})
