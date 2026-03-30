return {
	{
		'saghen/blink.cmp',
		version = 'v1.*',
		event = 'InsertEnter',
		dependencies = {
			'rafamadriz/friendly-snippets',
			{
				'L3MON4D3/LuaSnip',
				version = 'v2.*',
				build = 'make install_jsregexp',
			},
		},
		opts = {
			keymap = {
				preset = 'enter',
				['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
				['<C-e>'] = { 'hide', 'fallback' },
			},
			appearance = {
				nerd_font_variant = 'mono',
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
					show_on_accept_on_trigger_character = false,
					show_on_blocked_trigger_characters = { '{', '(', '}', ')' },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = 'rounded',
					},
				},
				menu = {
					scrollbar = false,
					draw = {
						treesitter = { 'lsp' },
						columns = {
							{ 'kind_icon' },
							{ 'label', 'label_description', gap = 1 },
							{ 'kind', gap = 1 },
							{ 'source_name', gap = 1 },
						},
					},
				},
			},
			snippets = {
				expand = function(snippet)
					require('luasnip').lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction)
					require('luasnip').jump(direction)
				end,
			},
			fuzzy = {
				implementation = 'prefer_rust_with_warning',
			},
			signature = {
				enabled = true,
				window = {
					border = 'rounded',
					show_documentation = false,
				},
			},
		},
		opts_extend = { 'sources.default' },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({
				enable_check_bracket_line = false,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	}
}
