return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        -- Install parsers
        local ensure_installed = {
            'lua', 'vim', 'vimdoc',
            'javascript', 'typescript',
            'c', 'cpp',
            'python', 'html', 'css',
            'markdown', 'markdown_inline',
        }
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyDone",
            once = true,
            callback = function()
                for _, lang in ipairs(ensure_installed) do
                    pcall(vim.treesitter.language.add, lang)
                end
            end,
        })

        -- treesitter folding (use built-in vim.treesitter.foldexpr)
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true

        -- folding keymaps
        vim.keymap.set('n', 'cj', 'za', { desc = 'Toggle fold under cursor' })
    end,
}
