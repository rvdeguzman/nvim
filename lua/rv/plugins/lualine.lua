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
                lualine_a = {
                    {
                        'mode',
                        color = function()
                            local mode = vim.fn.mode()
                            if mode == 'i' then
                                return { fg = "#000000", bg = "#7fa563", gui = "bold" } -- INSERT
                            elseif mode == 'c' then
                                return { fg = "#000000", bg = "#d8647e", gui = "bold" } -- COMMAND
                            elseif mode == 'v' or mode == 'V' or mode == '\22' then
                                return { fg = "#000000", bg = "#7e98e8", gui = "bold" } -- VISUAL
                            else
                                return { fg = "#000000", bg = "#fbcb97", gui = "bold" } -- NORMAL
                            end
                        end,
                    },
                },
                lualine_c = {
                    { 'filename', path = 1 },
                },
                lualine_x = { 'filetype' },
            },
        }
    end
}
