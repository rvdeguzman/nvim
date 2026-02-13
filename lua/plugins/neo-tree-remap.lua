return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    { "<leader>t", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>T", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },
}
