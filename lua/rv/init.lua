require('rv.opts')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true


vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-q>', '<cmd>qa!<CR>')
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>wd', '<cmd>close<CR>')

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')

require('rv.lazy_init')
