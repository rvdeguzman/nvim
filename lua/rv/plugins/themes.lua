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
                transparent = true,
            }
            vim.cmd.colorscheme 'vague'
        end
    },
    {
        'metalelf0/black-metal-theme-neovim',
    }
}
