return {
    {
        'rktjmp/lush.nvim'
    },
    {
        'ellisonleao/gruvbox.nvim'
    },
    {
        'sainnhe/gruvbox-material'
    },
    {
        'rebelot/kanagawa.nvim'
    },
    {
        'sainnhe/edge'
    },
    {
        'zenbones-theme/zenbones.nvim'
    },
    {
        'thesimonho/kanagawa-paper.nvim'
    },
    -- modified vague and black metal theme
    {
        'vague2k/vague.nvim',
        config = function()
            require('vague').setup {
                colors = {
                    -- bg = "#000000",
                    -- inactiveBg = "#000000",
                    -- fg = "#c1c1c1",
                    -- floatBorder = "#c1c1c1",
                    -- property = "#c1c1c1",
                    -- line = "#252530",
                    -- comment = "#606079",
                    -- builtin = "#b4d4cf",
                    -- func = "#c48282",
                    -- string = "#fbcb97",
                    -- number = "#e0a363",
                    -- constant = "#aeaed1",
                    -- parameter = "#bb9dbd",
                    -- visual = "#333333",
                    -- error = "#d8647e",
                    -- warning = "#f3be7c",
                    -- hint = "#7e98e8",
                    -- operator = "#9b99a3",
                    -- keyword = "#5f8787",
                    -- type = "#d0dfee",
                    -- search = "#405065",
                    -- plus = "#7fa563",
                    -- delta = "#f3be7c",
                },
                transparent = true,
            }
            vim.cmd.colorscheme 'vague'
        end
    },
    {
        'metalelf0/black-metal-theme-neovim',
    }
}
