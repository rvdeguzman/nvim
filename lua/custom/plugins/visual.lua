return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {
					NormalFloat = { link = "Normal" },
					FloatBorder = { link = "Normal" },
				},
				dim_inactive = false,
				transparent_mode = true,
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					globalstatus = true,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							color = function()
								local mode = vim.fn.mode()
								if mode == "i" then
									return { fg = "#000000", bg = "#7fa563", gui = "bold" }
								elseif mode == "c" then
									return { fg = "#000000", bg = "#d8647e", gui = "bold" }
								elseif mode == "v" or mode == "V" or mode == "\22" then
									return { fg = "#000000", bg = "#7e98e8", gui = "bold" }
								else
									return { fg = "#000000", bg = "#fbcb97", gui = "bold" }
								end
							end,
						},
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = { "filetype" },
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
				[[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
				[[⣿⣿⣿⡿⢫⣽⣿⣿⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿]],
				[[⣿⣿⠟⣡⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿]],
				[[⣿⠁⣾⣿⣿⣿⣿⠇⣀⣀⠀⠀⠀⢀⣀⣤⣤⣤⣤⣤⣤⣤⣄⣀⡀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠈⢻⣿⣿]],
				[[⣧⡾⠿⠿⠿⠛⠁⠈⠛⠛⠛⠛⠛⠛⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠛⠛⠛⠛⠛⠛⠁⠀⠀⠀⠀⠀⠀⠈⣿⣿]],
				[[⣿⣷⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣦⣤⣤⣤⣤⣄⣀⠀⠀⢹⣿]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("r", "  recent files", ":Telescope oldfiles<CR>"),
				dashboard.button("f", "  find file", ":Telescope find_files<CR>"),
				dashboard.button("s", "  restore session", function()
					require("persistence").load()
				end),
				dashboard.button("c", "  config", function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end),
				dashboard.button("u", "  update plugins", ":Lazy sync<CR>"),
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
	},
}
