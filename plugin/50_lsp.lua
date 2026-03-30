local diagnostic_jump_float = function(diagnostic)
  if diagnostic then
    vim.diagnostic.open_float(0, {
      scope = 'line',
      source = 'if_many',
    })
  end
end

vim.lsp.config('*', {
  root_markers = { '.git' },
})

Config.new_autocmd('LspAttach', '*', function(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client == nil then
    return
  end

  local buf = ev.buf
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buf = buf, silent = true, desc = desc })
  end

  map('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
  end, 'Hover documentation')

  map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
  map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')

  map('n', '[d', function()
    vim.diagnostic.jump({ count = -1, on_jump = diagnostic_jump_float })
  end, 'Previous diagnostic')

  map('n', ']d', function()
    vim.diagnostic.jump({ count = 1, on_jump = diagnostic_jump_float })
  end, 'Next diagnostic')

  map('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics to location list')
  map('i', '<C-s>', function()
    vim.lsp.buf.signature_help({ border = 'rounded' })
  end, 'Signature help')

  if client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
  end
end, 'Configure native LSP mappings')

vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'clangd',
  'pyright',
  'ruff',
})
