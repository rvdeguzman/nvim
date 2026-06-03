return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		dependencies = {
			{
				-- `snacks.nvim` integration is recommended, but optional
				---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
				"folke/snacks.nvim",
				optional = true,
				opts = {
					input = {}, -- Enhances `ask()`
					picker = { -- Enhances `select()`
						actions = {
							opencode_send = function(...)
								return require("opencode").snacks_picker_send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
				},
			},
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				events = {
					permissions = {
						edits = {
							enabled = true,
						},
					},
				},
			}

			vim.o.autoread = true -- Required for `opts.events.reload`

			-- Recommended/example keymaps
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to opencode", expr = true })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll opencode up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll opencode down" })

			-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
		end,
	},
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "InsertEnter",
		init = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_enabled = false
		end,
		keys = {
			{
				"<leader>at",
				function()
					if vim.g.copilot_enabled == false then
						vim.cmd("Copilot enable")
						print("Copilot enabled")
					else
						vim.cmd("Copilot disable")
						print("Copilot disabled")
					end
				end,
				desc = "Toggle Copilot",
			},
			{
				"<C-l>",
				'copilot#Accept("<CR>")',
				mode = "i",
				expr = true,
				replace_keycodes = false,
				silent = true,
				desc = "Accept Copilot suggestion",
			},
		},
		config = function()
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"ThePrimeagen/99",
		keys = {
			{
				"<leader>9v",
				function()
					require("99").visual()
				end,
				mode = "v",
				desc = "99 visual request",
			},
			{
				"<leader>9s",
				function()
					require("99").stop_all_requests()
				end,
				mode = "v",
				desc = "99 stop requests",
			},
		},
		config = function()
			local _99 = require("99")
			local cwd = vim.uv.cwd() or vim.fn.getcwd()
			local basename = vim.fs.basename(cwd)

			_99.setup({
				logger = {
					level = _99.INFO or _99.WARN or _99.ERROR,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
				md_files = {
					"AGENT.md",
				},
			})
		end,
	},
}
