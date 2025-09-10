return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        harpoon = require('harpoon')
        harpoon:setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        })

        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():add()
        end, { desc = 'Harpoon: Add file' })

        vim.keymap.set('n', '<leader>ho', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'Harpoon: Quick menu' })

        for i = 1, 9 do
            vim.keymap.set('n', '<leader>' .. i, function()
                harpoon:list():select(i)
            end, { desc = 'Harpoon: Jump to ' .. i })
        end
    end


}
