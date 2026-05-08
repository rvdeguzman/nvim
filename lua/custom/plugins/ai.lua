return {
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
