vim.pack.add({
    { src = 'https://github.com/mbbill/undotree.git' },
})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
