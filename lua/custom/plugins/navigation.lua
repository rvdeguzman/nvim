return {
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Move focus to the upper window' })
      vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Move focus to the right window' })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
      prompt = {
        enabled = false,
      },
    },
    keys = {
      {
        'f',
        function() require('flash').jump() end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash',
      },
      {
        'F',
        function() require('flash').treesitter() end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash Treesitter',
      },
      {
        'r',
        function() require('flash').remote() end,
        mode = 'o',
        desc = 'Remote Flash',
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup {
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
          save_on_toggle = true,
        },
      }

      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
      vim.keymap.set('n', '<leader>ho', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon quick menu' })

      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon to file ' .. i })
      end
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font } },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        columns = {
          'icon',
        },
        buf_options = {
          buflisted = false,
          bufhidden = 'hide',
        },
        win_options = {
          wrap = false,
          signcolumn = 'no',
          cursorcolumn = false,
          foldcolumn = '0',
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = 'nvic',
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          enabled = true,
          timeout_ms = 1000,
          autosave_changes = false,
        },
        constrain_cursor = 'editable',
        watch_for_changes = false,
        keymaps = {
          ['g?'] = { 'actions.show_help', mode = 'n' },
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = false,
          ['<C-h>'] = false,
          ['<C-t>'] = false,
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = { 'actions.close', mode = 'n' },
          ['<C-l>'] = false,
          ['-'] = { 'actions.parent', mode = 'n' },
          ['_'] = { 'actions.open_cwd', mode = 'n' },
          ['`'] = { 'actions.cd', mode = 'n' },
          ['g~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
          ['gs'] = { 'actions.change_sort', mode = 'n' },
          ['go'] = 'actions.open_external',
          ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
          ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, _) return name:match '^%.' ~= nil end,
          is_always_hidden = function(_, _) return false end,
          natural_order = 'fast',
          case_insensitive = false,
          sort = {
            { 'type', 'asc' },
            { 'name', 'asc' },
          },
        },
        git = {
          add = function(_) return false end,
          mv = function(_, _) return false end,
          rm = function(_) return false end,
        },
      }

      vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
