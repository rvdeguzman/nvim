vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

local oil = require('oil')
oil.setup({
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set('n', '-', '<cmd>Oil<CR>')
