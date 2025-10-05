return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = require("mapping"),
    win = {
      no_overlap = false,
      row = 30
    },
    debug = false,
  },
}
