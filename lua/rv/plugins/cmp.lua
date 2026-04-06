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
					auto_show = true,
					scrollbar = false,
					draw = {
						treesitter = { 'lsp' },
						columns = {
							{ 'kind_icon' },
							{ 'label', 'label_description', gap = 1 },
							{ 'kind', gap = 1 },
							{ 'source_name', gap = 1 },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
										local kind_icons = {
											Class = 'C',
											Color = '#',
										Constructor = '+',
										Constant = 'c',
										Enum = 'E',
										EnumMember = 'e',
										Event = '*',
										Field = '.',
										File = 'f',
										Folder = 'd',
										Function = 'f',
										Interface = 'I',
										Keyword = 'k',
										Method = 'm',
										Module = 'M',
										Operator = '=',
										Property = ':',
										Snippet = 'S',
										Struct = 'S',
										Text = 't',
										Unit = 'u',
										Value = 'v',
										Variable = 'v',
									}

									return kind_icons[ctx.kind] or ctx.kind_icon
								end,
							},
						},
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
			snippets = {
				preset = 'luasnip',
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
		config = function(_, opts)
			require('blink.cmp').setup(opts)

			vim.api.nvim_create_autocmd('ModeChanged', {
				group = vim.api.nvim_create_augroup('rv-blink-snippets', { clear = true }),
				pattern = { 's:n', 'i:n' },
				callback = function()
					local luasnip = require('luasnip')
					local current = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
					if current and not luasnip.session.jump_active then
						luasnip.unlink_current()
					end
				end,
			})
		end,
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
