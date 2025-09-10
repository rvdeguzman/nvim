return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local nvim_tree = require('nvim-tree')
        nvim_tree.setup({
            sync_root_with_cwd = true,
            view = { width = 32, side = 'right' },
            renderer = { group_empty = true },
            filters = { dotfiles = false },
            update_focused_file = { enable = true },
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            }
        })
        local api = require('nvim-tree.api')
        vim.keymap.set('n', '<leader>e', api.tree.toggle)
    end
}
