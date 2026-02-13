return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      dart_format = {
        command = "dart",
        args = { "format", "-" },
      },
    },
    formatters_by_ft = {
      dart = { "dart_format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
