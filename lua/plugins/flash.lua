return {
  "folke/flash.nvim",
  keys = {
    { "s", false },
    { "S", false },
    {
      "f",
      function() require("flash").jump() end,
      mode = { "n", "x", "o" },
      desc = "Flash jump",
    },
    {
      "F",
      function() require("flash").treesitter() end,
      mode = { "n", "x", "o" },
      desc = "Flash treesitter",
    },
    {
      "r",
      function() require("flash").remote() end,
      mode = "o",
      desc = "Flash remote",
    },
  },
  opts = {
    modes = {
      search = { enabled = true },
    },
    prompt = {
      enabled = false,
    },
  },
}
