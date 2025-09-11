return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        local copilot = require('copilot')
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                vim.b.copilot_suggestion_hidden = true
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.b.copilot_suggestion_hidden = false
            end,
        })
        copilot.setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
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
    end,
}
