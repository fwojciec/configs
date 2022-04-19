return {
	settings = {
		gopls = {
			directoryFilters = { "-/opt/homebrew/Cellar/go" },
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
				fieldalignment = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			staticcheck = true,
			semanticTokens = true,
		},
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		deepCompletion = true,
	},
}
