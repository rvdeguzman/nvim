vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

-- requires
require('lsp')
require('opts')
require('plugins.oil')
require('plugins.undotree')
require('plugins.harpoon')
require('plugins.tmux')
require('plugins.mini')
require('plugins.gitsigns')
require('plugins.telescope')
require('plugins.flash')

-- keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-q>', '<cmd>qa!<CR>')
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>wd', '<cmd>close<CR>')

vim.pack.add({
    -- themes
    { src = 'https://github.com/rktjmp/lush.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/sainnhe/gruvbox-material' },
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/sainnhe/edge' },
    { src = 'https://github.com/zenbones-theme/zenbones.nvim' },
    { src = 'https://github.com/thesimonho/kanagawa-paper.nvim' },
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/metalelf0/black-metal-theme-neovim' },
    -- ui
    { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
})

-- vague setup
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

-- indent blankline
require("ibl").setup()

-- autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            timeout = 75,
        })
    end,
})

-- sys clipboards
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>Y', '"+Y')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P')
