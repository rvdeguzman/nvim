return {
  -- Extend LazyVim's LSP config with additional servers and settings
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {
          settings = {
            javascript = { suggest = { autoImports = true } },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
        clangd = {},
        ruff = {},
        pyright = {},
      },
    },
  },
  -- Mason tool installer for formatters/linters
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
      },
    },
  },
}
