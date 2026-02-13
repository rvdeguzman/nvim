-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Quit
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })

-- Window splits
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close window" })

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- LSP aliases (LazyVim uses <leader>cr and <leader>cf)
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>F", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" })

-- Folding
map("n", "cj", "za", { desc = "Toggle fold under cursor" })
