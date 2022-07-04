require("user.lsp.null-ls")
require("user.lsp.nlspsettings")

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	severity_sort = true,
})

local server_opts = {}

-- go
server_opts.gopls = {
	settings = {
		gopls = {
			directoryFilters = { "-/opt/homebrew/Cellar/go" },
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
				-- fieldalignment = true,
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
		-- buildFlags = { "-tags=integration" },
	},
}

-- lua
server_opts.sumneko_lua = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}

-- jsonls
server_opts.jsonls = {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
}

local function on_attach(_, bufnr)
	local telescope = require("telescope.builtin")

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
	vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr })
	vim.keymap.set("n", "gtd", telescope.lsp_type_definitions, { buffer = bufnr })
	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = bufnr })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
	vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
	vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr })
	vim.keymap.set("n", "<leader>a", telescope.diagnostics, { buffer = bufnr })
	vim.keymap.set("n", "<leader>A", telescope.diagnostics)
	vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { buffer = bufnr })
	vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
	vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local common_setup_opts = {
	on_attach = on_attach,
	capabilities = capabilities,
}

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = vim.deepcopy(common_setup_opts)
	if server_opts[server.name] then
		opts = vim.tbl_deep_extend("force", opts, server_opts[server.name])
	end
	server:setup(opts)
end)
