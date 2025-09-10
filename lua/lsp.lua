vim.pack.add({
    { src = 'https://github.com/williamboman/mason.nvim' },
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

require('mason').setup()

pcall(function()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'stylua',
            'prettier',
        },
        run_on_start = true,
    })
end)


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local buf = args.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gt', vim.lsp.buf.type_definition)
        map('n', '<leader>rn', vim.lsp.buf.rename)
        map('n', '<leader>ca', vim.lsp.buf.code_action)
        map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
        map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
        map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
        map('n', '<leader>q', vim.diagnostic.setloclist)
        map('i', '<C-s>', vim.lsp.buf.signature_help)
    end,
})

local lspconfig = require('lspconfig')
local mlsp = require('mason-lspconfig')

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',        build = ':TSUpdate' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
})
local ts = require('nvim-treesitter.configs')
ts.setup({
    ensure_installed      = {
        'lua', 'vim', 'vimdoc',
        'javascript', 'typescript',
        'c', 'cpp',
        'python',
    },
    highlight             = { enable = true, additional_vim_regex_highlighting = false },
    indent                = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection   = '<CR>',
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

-- copilot
vim.pack.add({
    { src = 'https://github.com/zbirenbaum/copilot.lua' },
})

local copilot = require('copilot')
copilot.setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
            accept = '<C-e>',
            next = '<M-]>',
            prev = '<M-[>',
        },
    },
    panel = { enabled = false },
    filetypes = {
        markdown = true,
        help = true,
        ['*'] = true,
    },
})

-- flutter
vim.pack.add({
    { src = 'https://github.com/nvim-flutter/flutter-tools.nvim' }
})

-- cmp
vim.pack.add({
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),

        ['<Tab>']     = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>']   = cmp.mapping(function(fallback)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
cmp_lsp = require('cmp_nvim_lsp')
capabilities = cmp_lsp.default_capabilities(capabilities)

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
vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-jdtls' }
})

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

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'ts_ls', 'clangd', 'ruff', 'pyright' },
    automatic_enable = true, -- mason-lspconfig will `vim.lsp.enable()` installed servers
})

vim.pack.add({
    { src = 'https://github.com/windwp/nvim-autopairs' },
})

require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- conform
vim.pack.add({
    { src = 'https://github.com/stevearc/conform.nvim' },
})

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

-- nvim-lint
vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-lint' }
})

-- set up linters
require('lint').linters_by_ft = {
    python = { 'ruff' },
}

-- try lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
    end,
})
