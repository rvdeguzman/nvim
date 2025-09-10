return {
    'echasnovski/mini.nvim',
    config = function()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.icons').setup()
require('mini.extra').setup()
    end
}
