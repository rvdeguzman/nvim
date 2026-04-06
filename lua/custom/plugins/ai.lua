return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false

      vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })

      vim.keymap.set('n', '<leader>ct', function()
        if vim.g.copilot_enabled == false then
          vim.cmd 'Copilot enable'
          print 'Copilot enabled'
        else
          vim.cmd 'Copilot disable'
          print 'Copilot disabled'
        end
      end, { desc = 'Toggle Copilot' })
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    version = '^19.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion actions' },
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanion chat' },
      { '<leader>ai', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion inline' },
    },
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = os.getenv 'CLAUDE_CODE_OAUTH_TOKEN',
              },
            })
          end,
          codex = function()
            return require('codecompanion.adapters').extend('codex', {
              defaults = {
                auth_method = 'chatgpt',
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = 'claude_code',
        },
        inline = {
          adapter = 'claude_code',
        },
      },
      display = {
        chat = {
          window = {
            layout = 'vertical',
            width = 0.35,
          },
        },
      },
      opts = {
        log_level = 'ERROR',
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)

      if vim.env.CLAUDE_CODE_OAUTH_TOKEN == nil or vim.env.CLAUDE_CODE_OAUTH_TOKEN == '' then
        vim.schedule(function()
          vim.notify(
            "CodeCompanion: CLAUDE_CODE_OAUTH_TOKEN is not set in Neovim's environment",
            vim.log.levels.WARN
          )
        end)
      end

      if vim.fn.executable 'codex-acp' == 0 then
        vim.schedule(function()
          vim.notify('CodeCompanion: codex-acp is not installed or not in PATH', vim.log.levels.WARN)
        end)
      end
    end,
  },
  {
    'ThePrimeagen/99',
    config = function()
      local _99 = require '99'
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)

      _99.setup {
        logger = {
          level = _99.DEBUG,
          path = '/tmp/' .. basename .. '.99.debug',
          print_on_error = true,
        },
        md_files = {
          'AGENT.md',
        },
      }

      vim.keymap.set('v', '<leader>9v', function()
        _99.visual()
      end, { desc = '99 visual request' })

      vim.keymap.set('v', '<leader>9s', function()
        _99.stop_all_requests()
      end, { desc = '99 stop requests' })
    end,
  },
}
