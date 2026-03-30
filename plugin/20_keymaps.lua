local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<cr>')
map('n', '<C-q>', '<cmd>qa!<cr>')

map('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
map('n', '<leader>wh', '<cmd>split<cr>', { desc = 'Horizontal split' })
map('n', '<leader>wd', '<cmd>close<cr>', { desc = 'Close window' })

map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

map('n', '<leader>e', function()
  MiniFiles.open()
end, { desc = 'Explorer' })

map('n', '<leader><leader>', function()
  MiniPick.builtin.files()
end, { desc = 'Find files' })

map('n', '<leader>,', function()
  MiniPick.builtin.grep_live()
end, { desc = 'Live grep' })

map('n', '<leader>.', function()
  MiniPick.builtin.buffers()
end, { desc = 'Buffers' })

map('n', '<leader>fh', function()
  MiniPick.builtin.help()
end, { desc = 'Help tags' })

map('n', '<leader>fr', function()
  MiniPick.builtin.resume()
end, { desc = 'Resume picker' })

map('n', '<leader>bd', function()
  MiniBufremove.delete(0, false)
end, { desc = 'Delete buffer' })

map('n', '<leader>tw', function()
  MiniTrailspace.trim()
end, { desc = 'Trim trailing whitespace' })
