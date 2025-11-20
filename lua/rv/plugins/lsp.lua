return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            require('mason').setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local lspconfig = require('lspconfig')

            -- Setup capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { 'markdown', 'plaintext' },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = { 'documentation', 'detail', 'additionalTextEdits' },
                },
            }

            -- Setup lua_ls with custom settings
            lspconfig.lua_ls.setup({
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

            -- Setup ts_ls with custom settings
            lspconfig.ts_ls.setup({
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

            -- Setup mason-lspconfig
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'ts_ls', 'clangd', 'ruff', 'pyright' },
                automatic_install = true,
                handlers = {
                    -- Default handler
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    -- Prevent re-setup of servers already configured above
                    lua_ls = function() end,
                    ts_ls = function() end,
                },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
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
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Setup custom handlers for better UI
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = "rounded" }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, { border = "rounded" }
            )

            -- Setup keybindings on LspAttach
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
                    end

                    map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
                    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
                    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
                    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
                    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
                    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
                    map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
                        'Previous diagnostic')
                    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
                    map('n', '<leader>F', function() vim.lsp.buf.format({ async = true }) end, 'Format buffer')
                    map('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
                    map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature help')
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
                    'python', 'html', 'css',
                    'markdown', 'markdown_inline',
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
        'stevearc/conform.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('conform').setup({
                formatters = {
                    dart_format = {
                        command = 'dart',
                        args = { 'format', '-' },
                    }
                },
                formatters_by_ft = {
                    dart = { 'dart_format' },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = 'fallback'
                },
                notify_on_error = true,
            })
            vim.keymap.set({ 'n', 'v' }, '<leader>f',
                function() require('conform').format({ async = true, lsp_fallback = true }) end)
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    require("conform").format({ async = true })
                end,
            })
        end,
    },
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "nvim-flutter/flutter-tools.nvim",
        ft = "dart",
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup()
        end
    },
}
