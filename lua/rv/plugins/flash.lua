return {
    'folke/flash.nvim',
    config = function()
        local flash = require('flash')
        require('flash').setup {
            mode = 'search',
            prompt = {
                enabled = false,
            }
        }

        vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
            flash.jump()
        end)

        vim.keymap.set('o', 'r', function()
            flash.remote()
        end)

        vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
            flash.treesitter()
        end)
    end
}
