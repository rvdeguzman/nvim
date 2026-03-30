local diagnostic_jump_float = function(diagnostic)
	if diagnostic then
		vim.diagnostic.open_float(0, {
			scope = "line",
			source = "if_many",
		})
	end
end

vim.lsp.config("*", {
	root_markers = { ".git" },
})

local workspace_symbols = function()
	vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
		if query == nil or query == "" then
			return
		end

		vim.lsp.buf.workspace_symbol(query)
	end)
end

local hover_or_keywordprg = function()
	if next(vim.lsp.get_clients({ bufnr = 0 })) == nil then
		vim.cmd.normal({ "K", bang = true })
		return
	end

	local ok = pcall(vim.lsp.buf.hover, { border = "rounded" })
	if not ok then
		vim.cmd.normal({ "K", bang = true })
	end
end

vim.keymap.set("n", "K", hover_or_keywordprg, { desc = "Hover documentation" })

Config.new_autocmd("FileType", { "markdown", "help" }, function(ev)
	if vim.bo[ev.buf].buftype ~= "nofile" then
		return
	end

	local lang = vim.bo[ev.buf].filetype == "help" and "vimdoc" or "markdown"
	pcall(vim.treesitter.start, ev.buf, lang)
end, "Use built-in Treesitter in ephemeral doc buffers")

Config.new_autocmd("FileType", "*", function(ev)
	local ft = vim.bo[ev.buf].filetype
	if vim.tbl_contains({ "markdown_inline", "vimdoc" }, ft) then
		return
	end

	if vim.bo[ev.buf].buftype ~= "" then
		return
	end

	pcall(vim.treesitter.start, ev.buf)
end, "Use built-in Treesitter highlighting for normal buffers")

Config.new_autocmd("LspAttach", "*", function(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if client == nil then
		return
	end

	local buf = ev.buf
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buf = buf, silent = true, desc = desc })
	end

	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	map("n", "gr", vim.lsp.buf.references, "References")
	map("n", "gt", vim.lsp.buf.type_definition, "Type definitions")
	map("n", "<leader>sf", vim.lsp.buf.document_symbol, "Document symbols")
	map("n", "<leader>ws", workspace_symbols, "Workspace symbols")
	map("n", "<leader>xx", function()
		vim.diagnostic.setloclist({ open = true })
	end, "Buffer diagnostics")
	map("n", "<leader>xw", function()
		vim.diagnostic.setqflist({ open = true })
	end, "Workspace diagnostics")

	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, on_jump = diagnostic_jump_float })
	end, "Previous diagnostic")

	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, on_jump = diagnostic_jump_float })
	end, "Next diagnostic")

	map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to location list")
	map("i", "<C-s>", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, "Signature help")

	if client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = buf })
	end
end, "Configure native LSP mappings")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"clangd",
	"pyright",
	"ruff",
})
