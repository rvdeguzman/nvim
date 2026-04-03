return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"python",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"json",
				"yaml",
				"rust",
			},
			auto_install = true,
		})

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldenable = true

		vim.keymap.set("n", "cj", "za", { desc = "Toggle fold under cursor" })
	end,
}
