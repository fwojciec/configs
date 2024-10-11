local lspconfig = require("lspconfig")

-- local function format_callback(bufnr, async)
--   vim.lsp.buf.format({
--     bufnr = bufnr,
--     async = async,
--     filter = function(client)
--       return require("fw.utils").includes({ "sumneko_lua", "html", "cssls", "denols", "dockerls" }, client.name)
--     end,
--   })
-- end

local function custom_on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	if client.server_capabilities.semanticTokensProvider then
		client.server_capabilities.semanticTokensProvider = nil
	end

	vim.diagnostic.config({
		virtual_text = false,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- lspconfig.lua_ls.setup({
-- 	on_attach = custom_on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 				path = runtime_path,
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim", "redis", "RELOAD" },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 				checkThirdParty = false,
-- 			},
-- 			telemetry = { enable = false },
-- 		},
-- 	},
-- })

require("neodev").setup({})

lspconfig.lua_ls.setup({
	on_attach = custom_on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = custom_on_attach,
	capabilities = capabilities,
})

-- lspconfig.denols.setup({
-- 	capabilities = capabilities,
-- 	on_attach = custom_on_attach,
-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- })

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
	root_dir = lspconfig.util.root_pattern("package.json"),
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	settings = {
		eslint = {
			format = {
				enable = false,
			},
		},
	},
	on_attach = custom_on_attach,
	root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

-- lspconfig.helm_ls.setup({
-- 	filetypes = { "helm" },
-- 	cmd = { "helm-ls", "serve" },
-- 	capabilities = capabilities,
-- 	on_attach = custom_on_attach,
-- })

lspconfig.yamlls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
	root_dir = lspconfig.util.root_pattern("Chart.yaml", ".eslintrc.js", ".eslintrc.json"),
	settings = {
		yaml = {
			keyOrdering = false,
		},
	},
})

lspconfig.bufls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.zls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.ccls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.terraformls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
	cmd = { "/Users/filip/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer" },
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
	root_dir = lspconfig.util.root_pattern("pyrightconfig.json", "pyproject.toml"),
})

lspconfig.ruff_lsp.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

lspconfig.ltex.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("ltex_extra").setup({
			load_langs = { "en-US", "pl-PL" },
			init_check = true,
			path = "/Users/filip/.config/nvim/ltex",
			log_level = "none",
		})
		custom_on_attach(client, bufnr)
	end,
})

require("lspconfig").bashls.setup({
	capabilities = capabilities,
	on_attach = custom_on_attach,
})

-- lspconfig.tailwindcss.setup {
--   capabilities = capabilities,
--   on_attach = custom_on_attach,
-- }

-- lspconfig["starlark-rust"].setup {
--   capabilities = capabilities,
--   on_attach = custom_on_attach,
--   filetypes = { "star", "bzl", "BUILD.bazel", "starlark" }
-- }
