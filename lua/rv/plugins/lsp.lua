return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							hint = { enable = true },
							telemetry = { enable = false },
						},
					},
				},
				ts_ls = {
					settings = {
						javascript = {
							suggest = { autoImports = true },
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayVariableTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
							},
						},
						typescript = {
							suggest = { autoImports = true },
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
					},
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--completion-style=detailed",
						"--header-insertion=iwyu",
					},
				},
				ruff = {},
				pyright = {},
			}

			vim.lsp.config["*"] = {
				capabilities = capabilities,
				root_markers = { ".git" },
			}

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = true,
				automatic_enable = false,
			})

			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"prettier",
				},
				run_on_start = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Setup custom handlers for better UI
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

			-- Setup keybindings on LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					local buf = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
					end

					map("n", "K", vim.lsp.buf.hover, "Hover documentation")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cl", vim.lsp.codelens.run, "Run code lens")
					map("n", "<leader>e", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Previous diagnostic")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")
					map("n", "<leader>F", function()
						vim.lsp.buf.format({ async = true })
					end, "Format buffer")
					map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
					map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")

					if client:supports_method("textDocument/documentHighlight") then
						local highlight_group = vim.api.nvim_create_augroup("rv-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = buf,
							group = highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
							buffer = buf,
							group = highlight_group,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
						map("n", "<leader>uh", function()
							local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
							vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
						end, "Toggle inlay hints")
					end

					if client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh()
						local codelens_group = vim.api.nvim_create_augroup("rv-lsp-codelens", { clear = false })
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = buf,
							group = codelens_group,
							callback = vim.lsp.codelens.refresh,
						})
					end
				end,
			})
		end,
	},
}
