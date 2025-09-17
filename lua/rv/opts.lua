vim.opt.winborder = 'bold'

vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- files
vim.opt.undofile = true
vim.opt.swapfile = false

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- timeouts
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false
vim.opt.list = true

-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            timeout = 75,
        })
    end,
})

vim.diagnostic.config({
    source = true,
})
