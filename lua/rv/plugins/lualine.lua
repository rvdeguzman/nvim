return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = false,
                theme = 'auto',
                globalstatus = true,
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                lualine_x = { 'filetype' },
            },
        }
    end
}
