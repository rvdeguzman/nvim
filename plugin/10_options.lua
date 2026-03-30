vim.opt.winborder = 'bold'

vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }

vim.opt.timeoutlen = 400
vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

vim.diagnostic.config({
  severity_sort = true,
  source = 'if_many',
  float = {
    border = 'rounded',
    source = 'if_many',
    focusable = true,
  },
  virtual_text = {
    prefix = '●',
  },
})

Config.new_autocmd('TextYankPost', '*', function()
  vim.highlight.on_yank({ timeout = 75 })
end, 'Highlight yanked text')
