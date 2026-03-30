return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion actions" },
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion chat" },
		{ "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion inline" },
	},
	opts = {
		adapters = {
			acp = {
				claude_code = function()
					return require("codecompanion.adapters").extend("claude_code", {
						env = {
							CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN"),
						},
					})
				end,
			},
		},
		strategies = {
			chat = {
				adapter = "claude_code",
			},
			inline = {
				adapter = "claude_code",
			},
		},
		display = {
			chat = {
				window = {
					layout = "vertical",
					width = 0.35,
				},
			},
		},
		opts = {
			log_level = "ERROR",
		},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)

		if vim.env.CLAUDE_CODE_OAUTH_TOKEN == nil or vim.env.CLAUDE_CODE_OAUTH_TOKEN == "" then
			vim.schedule(function()
				vim.notify(
					"CodeCompanion: CLAUDE_CODE_OAUTH_TOKEN is not set in Neovim's environment",
					vim.log.levels.WARN
				)
			end)
		end
	end,
}
