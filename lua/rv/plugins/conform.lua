return {
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
}
