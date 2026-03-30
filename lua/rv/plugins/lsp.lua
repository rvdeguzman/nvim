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

			vim.lsp.config["*"] = {
				capabilities = capabilities,
			}

			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}

			vim.lsp.config.ts_ls = {
				settings = {
					javascript = { suggest = { autoImports = true } },
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayVariableTypeHints = true,
						},
					},
				},
			}

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "clangd", "ruff", "pyright" },
				automatic_install = true,
			})

			vim.lsp.enable({ "lua_ls", "ts_ls", "clangd", "ruff", "pyright" })
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
				end,
			})
		end,
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		ft = "dart",
	},
}
