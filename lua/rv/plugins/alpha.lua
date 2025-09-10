return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local alpha = require('alpha')

        local dashboard = require('alpha.themes.dashboard')
        dashboard.section.header.val = {
            "                                                                              ",
            "=================     ===============     ===============   ========  ========",
            "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
            "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
            "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
            "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
            "|| . .||   ||. *-|| ||-* .||   ||. . || || . .||   ||. *-|| ||-*.|\\ . . . . ||",
            "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
            "|| . *||   ||    || ||    ||   ||* . || || . *||   ||    || ||   |\\ `-*/| . ||",
            "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
            "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
            "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
            "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
            "||         .=='   \\_|-_ `===. .==='   |   `===. .===' _-|/   `==  \\/  |   ||",
            "||      .=='    *-'    *`-  `='    *-'   *`-    `='  *-'   `-*  /|  \\/  |   ||",
            "||   .=='    *-'          *`-_\\._-'         `-_./__-'         `' |. /|  |   ||",
            "||.=='    _-'                                                     `' |  /==.||",
            "=='    _-'                        N E O V I M                         \\/   `==",
            "\\   *-'                                                                `-*   /",
            " `''                                                                      ``'  ",
        }

        dashboard.section.buttons.val = {
            dashboard.button("r", "  recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("f", "  find file", ":Telescope find_files<CR>"),
            dashboard.button("c", "  config", function()
                require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
            end),
            dashboard.button("l", "  lazy", ":Lazy<CR>"),
            dashboard.button("m", "  mason", ":Mason<CR>"),
            dashboard.button("q", "  quit", ":qa<CR>"),
        }

        local function footer()
            local v = vim.version()
            local datetime = os.date("%H:%M  %d-%m-%Y")
            return ("󰚌 rv dgzzz   %s   v%d.%d.%d"):format(datetime, v.major, v.minor, v.patch)
        end

        dashboard.section.footer.val = footer()
        alpha.setup(dashboard.opts)
    end,
}
