return {
  {
    "ecthelionvi/NeoComposer.nvim",
    enabled = false,
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      colors = {
        bg = "#313245",
        fg = "#ff9e64",
        red = "#f38ba9",
        blue = "#89b4fb",
        green = "#a6e3a2",
      },
      keymaps = {
        cycle_next = "<c-m><c-n>",
        cycle_prev = "<c-m><c-p>",
      },
    }
  },
}
