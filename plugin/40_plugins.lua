Config.on_packchanged('nvim-treesitter', { 'install', 'update' }, function()
  vim.cmd('TSUpdate')
end, 'Update Treesitter parsers after plugin changes')

Config.now(function()
  vim.pack.add({
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/christoomey/vim-tmux-navigator',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/olimorris/codecompanion.nvim',
    'https://github.com/github/copilot.vim',
    'https://github.com/ThePrimeagen/99',
  }, {
    confirm = false,
  })
end)

Config.now(function()
  require('gruvbox').setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    inverse = true,
    transparent_mode = true,
    overrides = {
      NormalFloat = { link = 'Normal' },
      FloatBorder = { link = 'Normal' },
    },
  })

  vim.cmd.colorscheme('gruvbox')
end)

Config.later(function()
  require('gitsigns').setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, lhs, rhs, desc, extra)
        local opts = vim.tbl_extend('force', { buf = bufnr, desc = desc }, extra or {})
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(gs.next_hunk)
        return '<Ignore>'
      end, 'Next hunk', { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(gs.prev_hunk)
        return '<Ignore>'
      end, 'Previous hunk', { expr = true })

      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
      map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
      map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
      map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
      map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>hb', function()
        gs.blame_line({ full = true })
      end, 'Blame line')
      map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle line blame')
      map('n', '<leader>hd', gs.diffthis, 'Diff this')
      map('n', '<leader>hD', function()
        gs.diffthis('~')
      end, 'Diff this against ~')
      map('n', '<leader>td', gs.toggle_deleted, 'Toggle deleted')
    end,
  })
end)

Config.later(function()
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      markdown = { 'prettier' },
      yaml = { 'prettier' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      python = { 'ruff_format', 'black' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    notify_on_error = true,
  })

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
  end, { desc = 'Format buffer' })
end)

Config.later(function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'rust',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
end)

Config.later(function()
  vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>')
  vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>')
  vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>')
  vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>')
end)

Config.later(function()
  require('codecompanion').setup({
    adapters = {
      acp = {
        claude_code = function()
          return require('codecompanion.adapters').extend('claude_code', {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = os.getenv('CLAUDE_CODE_OAUTH_TOKEN'),
            },
          })
        end,
        codex = function()
          return require('codecompanion.adapters').extend('codex', {
            defaults = { auth_method = 'chatgpt' },
          })
        end,
      },
    },
    strategies = {
      chat = { adapter = 'claude_code' },
      inline = { adapter = 'claude_code' },
    },
    display = {
      chat = {
        window = {
          layout = 'vertical',
          width = 0.35,
        },
      },
    },
    opts = { log_level = 'ERROR' },
  })

  vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion actions' })
  vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'CodeCompanion chat' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'CodeCompanion inline' })
end)

Config.later(function()
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_enabled = false

  vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
    expr = true,
    replace_keycodes = false,
    silent = true,
  })

  vim.keymap.set('n', '<leader>ct', function()
    if vim.g.copilot_enabled then
      vim.cmd('Copilot disable')
      vim.g.copilot_enabled = false
    else
      vim.cmd('Copilot enable')
      vim.g.copilot_enabled = true
    end
  end, { desc = 'Toggle Copilot' })
end)

Config.later(function()
  local ninety_nine = require('99')
  local basename = vim.fs.basename(vim.uv.cwd())

  ninety_nine.setup({
    logger = {
      level = ninety_nine.DEBUG,
      path = '/tmp/' .. basename .. '.99.debug',
      print_on_error = true,
    },
    completion = {
      custom_rules = { 'scratch/custom_rules/' },
      files = {},
      source = nil,
    },
    md_files = { 'AGENT.md' },
  })

  vim.keymap.set('v', '<leader>9v', function()
    ninety_nine.visual()
  end, { desc = '99 visual prompt' })

  vim.keymap.set('v', '<leader>9s', function()
    ninety_nine.stop_all_requests()
  end, { desc = '99 stop requests' })
end)
