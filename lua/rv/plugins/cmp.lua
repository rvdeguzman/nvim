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
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            completion = {
                menu = {
                    draw = {
                        treesitter = { 'lsp' }
                    }
                },
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'rounded',
                    }
                }
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },
            fuzzy = {
                implementation = 'rust',
            },
            signature = {
                enabled = true,
                window = {
                    border = 'rounded',
                }
            }
        },
        opts_extend = { 'sources.default' }
    },
    -- nvim-autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup()
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
