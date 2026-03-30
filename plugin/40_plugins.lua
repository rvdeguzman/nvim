Config.now(function()
  vim.pack.add({
    'https://github.com/goolord/alpha-nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/folke/flash.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/christoomey/vim-tmux-navigator',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/olimorris/codecompanion.nvim',
    'https://github.com/github/copilot.vim',
    'https://github.com/ThePrimeagen/99',
  }, {
    confirm = false,
  })
end)

Config.later(function()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.dashboard')

  dashboard.section.header.val = {
    '                                     ',
    '  N E O V I M   0 . 1 2              ',
    '                                     ',
  }

  dashboard.section.buttons.val = {
    dashboard.button('e', 'Open explorer', '<cmd>lua MiniFiles.open()<cr>'),
    dashboard.button('f', 'Recent files', '<cmd>browse oldfiles<cr>'),
    dashboard.button('s', 'Recent sessions', '<cmd>lua MiniSessions.select()<cr>'),
    dashboard.button(
      'n',
      'New named session',
      [[<cmd>lua vim.ui.input({ prompt = 'Session name: ' }, function(name) if name ~= nil and name ~= '' then MiniSessions.write(name) end end)<cr>]]
    ),
    dashboard.button('m', 'Mason', '<cmd>Mason<cr>'),
    dashboard.button('q', 'Quit', '<cmd>qa<cr>'),
  }

  dashboard.section.footer.val = {
    'mini-first, native LSP, vim.pack',
  }

  alpha.setup(dashboard.config)

  Config.new_autocmd('FileType', 'alpha', function()
    vim.opt_local.foldenable = false
  end, 'Disable folding on alpha buffer')

  Config.new_autocmd('VimEnter', '*', function()
    if vim.fn.argc() > 0 then
      return
    end

    local curbuf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(curbuf)
    local lines = vim.api.nvim_buf_get_lines(curbuf, 0, -1, false)
    local is_empty = #lines == 1 and lines[1] == ''

    if name == '' and is_empty and vim.bo[curbuf].buftype == '' then
      vim.cmd.Alpha()
    end
  end, 'Open alpha on empty startup')
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

Config.now(function()
  require('lualine').setup({
    options = {
      icons_enabled = false,
      theme = 'auto',
      globalstatus = true,
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_a = {
        {
          'mode',
          color = function()
            local mode = vim.fn.mode()
            if mode == 'i' then
              return { fg = '#000000', bg = '#7fa563', gui = 'bold' }
            elseif mode == 'c' then
              return { fg = '#000000', bg = '#d8647e', gui = 'bold' }
            elseif mode == 'v' or mode == 'V' or mode == '\22' then
              return { fg = '#000000', bg = '#7e98e8', gui = 'bold' }
            else
              return { fg = '#000000', bg = '#fbcb97', gui = 'bold' }
            end
          end,
        },
      },
      lualine_c = {
        { 'filename', path = 1 },
      },
      lualine_x = { 'filetype' },
    },
  })
end)

Config.later(function()
  local harpoon = require('harpoon')

  harpoon:setup({
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  })

  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = 'Harpoon add file' })

  vim.keymap.set('n', '<leader>ho', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = 'Harpoon quick menu' })

  for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function()
      harpoon:list():select(i)
    end, { desc = 'Harpoon jump ' .. i })
  end
end)

Config.later(function()
  local flash = require('flash')

  flash.setup({
    mode = 'search',
    prompt = {
      enabled = false,
    },
  })

  vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
    flash.jump()
  end, { desc = 'Flash jump' })

  vim.keymap.set('o', 'r', function()
    flash.remote()
  end, { desc = 'Flash remote' })

  vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
    flash.treesitter()
  end, { desc = 'Flash treesitter' })
end)

Config.now(function()
  require('mason').setup({
    PATH = 'prepend',
  })
end)

Config.later(function()
  require('mason-tool-installer').setup({
    ensure_installed = {
      'lua-language-server',
      'typescript-language-server',
      'clangd',
      'pyright',
      'ruff',
      'stylua',
      'prettier',
      'clang-format',
      'black',
    },
    run_on_start = true,
    start_delay = 3000,
  })
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
  vim.g.disable_autoformat = false

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
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end

      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
    notify_on_error = true,
  })

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
  end, { desc = 'Format buffer' })

  vim.api.nvim_create_user_command('FormatDisable', function()
    vim.g.disable_autoformat = true
  end, { desc = 'Disable format on save' })

  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.g.disable_autoformat = false
  end, { desc = 'Enable format on save' })

  vim.keymap.set('n', '<leader>tf', function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
  end, { desc = 'Toggle format on save' })
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

  vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'CodeCompanion chat' })
  vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion actions' })
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
