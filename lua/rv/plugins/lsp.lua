return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require('mason').setup()
            require('mason-tool-installer').setup({
                ensure_installed = {
                    'stylua',
                    'prettier',
                },
                run_on_start = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
                    end

                    map('n', 'K', vim.lsp.buf.hover)
                    map('n', 'gD', vim.lsp.buf.declaration)
                    map('n', '<leader>rn', vim.lsp.buf.rename)
                    map('n', '<leader>ca', vim.lsp.buf.code_action)
                    map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
                    map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
                    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
                    map('n', '<leader>q', vim.diagnostic.setloclist)
                    map('i', '<C-s>', vim.lsp.buf.signature_help)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'lua', 'vim', 'vimdoc',
                    'javascript', 'typescript',
                    'c', 'cpp',
                    'python',
                },
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        node_decremental = '<BS>',
                    },
                },
            })

            -- treesitter folding
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true

            -- folding keymaps
            vim.keymap.set('n', 'cj', 'za', { desc = 'Toggle fold under cursor' })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp_signature_help' },
                }, {
                    { name = 'path' },
                    { name = 'buffer' },
                }),
            })
        end,
    },
    -- mason
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require('mason').setup()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
                settings = {
                    javascript = { suggest = { autoImports = true } },
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayVariableTypeHints = true,
                        },
                    },
                },
            })

            -- java
            local home = os.getenv('HOME')
            local current_path = home .. "/.sdkman/candidates/java/current"
            local lombok_path = home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"
            local root_markers = { 'gradlew', 'mvnw', '.git' }
            local root_dir = require('jdtls.setup').find_root(root_markers)
            local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

            vim.lsp.config('jdtls', {
                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        cmd = {
                            current_path .. "/bin/java",
                            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                            '-Dosgi.bundles.defaultStartLevel=4',
                            '-Declipse.product=org.eclipse.jdt.ls.core.product',
                            '-Dlog.protocol=true',
                            '-Dlog.level=ALL',
                            '-Xmx4g',
                            '--add-modules=ALL-SYSTEM',
                            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                            '-javaagent:' .. lombok_path,
                            '-jar', vim.fn.glob(home ..
                            '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
                            '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
                            '-data', workspace_folder,
                        }
                    }
                }
            })
            vim.lsp.enable('jdtls')
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'ts_ls', 'clangd', 'ruff', 'pyright' },
                automatic_enable = true,
            })
        end,
    },
    -- nvim-autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require('nvim-autopairs').setup()

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    -- conform
    {
        'stevearc/conform.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    -- You can customize some of the format options for the filetype (:help conform.format)
                    -- Conform will run the first available formatter
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = 'fallback'
                },
                formatters = {
                    -- formatter configs
                }
            })
        end,

    },
    -- nvim-lint
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                python = { 'ruff' },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
