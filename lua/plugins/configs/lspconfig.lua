-- Configure diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be "●", "▎", "■", etc.
		spacing = 4,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- LspAttach autocommand to set buffer-local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }

		-- shift + Tab
		vim.keymap.set("n", "<S-Tab>", vim.lsp.buf.hover, opts) -- <Shift+K> is just "K"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

		-- Enable format on save for LSP servers that support formatting
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = ev.buf,
				callback = function()
					-- vim.lsp.buf.format({ bufnr = ev.buf, async = true })
				end,
			})
		end
	end,
})

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enhanced completion capabilities
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- Code action capabilities
capabilities.textDocument.codeAction = {
	dynamicRegistration = false,
	codeActionLiteralSupport = {
		codeActionKind = {
			valueSet = {
				"",
				"quickfix",
				"refactor",
				"refactor.extract",
				"refactor.inline",
				"refactor.rewrite",
				"source",
				"source.organizeImports",
			},
		},
	},
}

-- Enhanced publish diagnostics capabilities
capabilities.textDocument.publishDiagnostics = {
	relatedInformation = true,
	tagSupport = {
		valueSet = { 1, 2 },
	},
	versionSupport = true,
}

-- LSP servers to setup
local servers = {
	"pyright",
	"ts_ls",
	"cssls",
	"html",
	"jsonls",
	"lua_ls",
	"gopls",
	"terraformls",
	"yamlls",
	"tailwindcss",
	"sqlls",
	"prismals",
	"marksman",
	"taplo", -- TOML
	-- Enhanced LSP servers for better code actions
	"eslint", -- Better ESLint integration for JS/TS
	"copilot", -- GitHub Copilot
}

-- Filetypes for each server
local filetypes_map = {
	pyright = { "python" },
	ts_ls = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	cssls = { "css", "scss", "less" },
	html = { "html" },
	jsonls = { "json", "jsonc" },
	lua_ls = { "lua" },
	gopls = { "go" },
	terraformls = { "terraform", "tf" },
	yamlls = { "yaml", "yaml.docker-compose" },
	tailwindcss = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"php",
		"blade",
	},
	sqlls = { "sql" },
	prismals = { "prisma" },
	marksman = { "markdown" },
	taplo = { "toml" },
	eslint = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
	copilot = { "python", "javascript", "typescript", "lua", "go", "rust", "java", "c", "cpp" }, -- Add common filetypes for Copilot
}
--
-- Setup each server via lspconfig
-- vim.lsp.config.sourcekit = {
-- 	cmd = {
-- 		"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
-- 	},
-- 	filetypes = { "swift", "objective-c", "objective-cpp" },
-- 	root_dir = function(filename, _)
-- 		local util = require("lspconfig.util")
-- 		return util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
-- 			or util.root_pattern("Package.swift")(filename)
-- 	end,
-- 	capabilities = capabilities,
-- }
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "swift",
-- 	callback = function()
-- 		local clients = vim.lsp.get_clients({ bufnr = 0 })
-- 		for _, c in ipairs(clients) do
-- 			if c.name == "sourcekit" then
-- 				return
-- 			end
-- 		end
--
-- 		vim.lsp.start({
-- 			name = "sourcekit",
-- 			cmd = {
-- 				"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
-- 			},
-- 			filetypes = { "swift", "objective-c", "objective-cpp" },
-- 			root_dir = function(filename, _)
-- 				local util = require("lspconfig.util")
-- 				return util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
-- 					or util.root_pattern("Package.swift")(filename)
-- 			end,
-- 			-- capabilities = capabilities,
-- 		})
-- 	end,
-- })
--
for _, server in ipairs(servers) do
	-- Server-specific configurations
	local server_opts = {
		capabilities = capabilities,
		filetypes = filetypes_map[server] or {},
	}

	-- Enhanced configurations for specific servers
	if server == "pyright" then
		server_opts.settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					completeFunctionParens = true,
					autoSearchPaths = true,
					extraPaths = {},
					-- Disable some diagnostics that Ruff handles better
					diagnosticSeverityOverrides = {
						reportUnusedImport = "none", -- Ruff handles this
						reportUnusedVariable = "none", -- Ruff handles this
						reportMissingImports = "none", -- Ruff handles this
					},
				},
			},
		}
	elseif server == "ts_ls" then
		server_opts.settings = {
			typescript = {
				format = { enable = false }, -- Let conform handle formatting
				suggest = { includeCompletionsForModuleExports = true },
			},
			javascript = {
				format = { enable = false }, -- Let conform handle formatting
				suggest = { includeCompletionsForModuleExports = true },
			},
		}
	elseif server == "lua_ls" then
		server_opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		}
	elseif server == "eslint" then
		server_opts.settings = {
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = "separateLine",
				},
				showDocumentation = {
					enable = true,
				},
			},
			format = false, -- Let conform handle formatting
			run = "onType",
			validate = "on",
		}
	elseif server == "copilot" then
		server_opts.cmd = { "copilot-language-server", "--stdio" }
		server_opts.root_markers = { ".git" }
	end

	vim.lsp.config[server] = server_opts
end

vim.lsp.enable(servers)
