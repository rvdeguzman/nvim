return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    -- Override LazyVim's <leader>, (buffers) with live grep
    { "<leader>,", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>.", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ previewer = false })
        )
      end,
      desc = "Buffer fuzzy find",
    },
    { "<leader>ss", function() require("telescope.builtin").lsp_document_symbols({}) end, desc = "Document symbols" },
    { "<leader>st", "<cmd>Telescope treesitter<cr>", desc = "Treesitter symbols" },
    { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP type definitions" },
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
    {
      "<leader>sf",
      function()
        require("telescope.builtin").lsp_document_symbols({
          initial_text = "",
          ignore_symbols = {
            "variable", "constant", "string", "number", "object",
            "field", "property", "key", "array", "boolean", "package",
          },
        })
      end,
      desc = "Document symbols (filtered)",
    },
    { "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown(),
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
