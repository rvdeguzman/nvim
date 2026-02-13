-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true

-- Window borders
vim.opt.winborder = "bold"

-- Tabs / indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Files
vim.opt.swapfile = false

-- Display
vim.opt.scrolloff = 10
vim.opt.wrap = false

-- Timing
vim.opt.updatetime = 300

-- Treesitter folding (applied per-buffer to avoid errors on dashboard/special buffers)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterFolding", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if pcall(vim.treesitter.get_parser, buf) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  source = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    focusable = true,
  },
  virtual_text = {
    prefix = "●",
  },
})
