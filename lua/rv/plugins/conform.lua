return {
	'stevearc/conform.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		vim.g.disable_autoformat = false

		require('conform').setup({
			formatters = {
				dart_format = {
					command = 'dart',
					args = { 'format', '-' },
				},
			},
			formatters_by_ft = {
				lua = { 'stylua', stop_after_first = true },
				javascript = { 'prettier', stop_after_first = true },
				javascriptreact = { 'prettier', stop_after_first = true },
				typescript = { 'prettier', stop_after_first = true },
				typescriptreact = { 'prettier', stop_after_first = true },
				json = { 'prettier', stop_after_first = true },
				html = { 'prettier', stop_after_first = true },
				css = { 'prettier', stop_after_first = true },
				markdown = { 'prettier', stop_after_first = true },
				yaml = { 'prettier', stop_after_first = true },
				c = { 'clang_format' },
				cpp = { 'clang_format' },
				python = { 'ruff_format', 'black', stop_after_first = true },
				rust = { 'rustfmt', stop_after_first = true },
				sh = { 'shfmt', stop_after_first = true },
				bash = { 'shfmt', stop_after_first = true },
				zsh = { 'shfmt', stop_after_first = true },
				dart = { 'dart_format' },
			},
			format_on_save = function(_)
				if vim.g.disable_autoformat then
					return
				end

				return {
					timeout_ms = 500,
					lsp_format = 'fallback',
				}
			end,
			notify_on_error = true,
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
			require('conform').format({
				async = true,
				lsp_fallback = true,
			})
		end, { desc = 'Format buffer' })

		vim.api.nvim_create_user_command('FormatDisable', function(_)
			vim.g.disable_autoformat = true
		end, {
			desc = 'Disable autoformat-on-save',
		})

		vim.api.nvim_create_user_command('FormatEnable', function()
			vim.g.disable_autoformat = false
		end, {
			desc = 'Enable autoformat-on-save',
		})
	end,
}
