return {
	"https://github.com/github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_enabled = false
		vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', {
			expr = true,
			replace_keycodes = false,
			silent = true,
		})
		vim.keymap.set("n", "<leader>ct", function()
			if vim.g.copilot_enabled == false then
				vim.cmd("Copilot enable")
				print("Copilot enabled")
			else
				vim.cmd("Copilot disable")
				print("Copilot disabled")
			end
		end, { desc = "Toggle Copilot" })
	end,
}
