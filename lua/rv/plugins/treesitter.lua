return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
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
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})

		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldenable = true

		vim.keymap.set('n', 'cj', 'za', { desc = 'Toggle fold under cursor' })
	end,
}
