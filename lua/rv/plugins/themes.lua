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
    {
        'vague2k/vague.nvim',
        config = function()
            require('vague').setup {
                colors = {
                    bg = "#000000",
                    inactiveBg = "#000000",
                    fg = "#c1c1c1",
                    floatBorder = "#878787",
                    line = "#252530",
                    comment = "#606079",
                    builtin = "#b4d4cf",
                    func = "#c48282",
                    string = "#fbcb97",
                    number = "#e0a363",
                    property = "#c1c1c1",
                    constant = "#aeaed1",
                    parameter = "#bb9dbd",
                    visual = "#333333",
                    error = "#d8647e",
                    warning = "#f3be7c",
                    hint = "#7e98e8",
                    operator = "#9b99a3",
                    keyword = "#5f8787",
                    type = "#d0dfee",
                    search = "#405065",
                    plus = "#7fa563",
                    delta = "#f3be7c",
                },
            }

            vim.cmd.colorscheme 'vague'
        end
    },
    {
        'metalelf0/black-metal-theme-neovim',
    }
}
