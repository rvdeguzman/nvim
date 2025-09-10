vim.pack.add({
    { src = 'https://github.com/echasnovski/mini.nvim' },
})

require('mini.ai').setup()
require('mini.surround').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.icons').setup()
require('mini.extra').setup()

