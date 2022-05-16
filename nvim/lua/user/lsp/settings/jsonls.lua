local schemastore = require("schemastore")

local opts = {
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
		},
	},
}

return opts
