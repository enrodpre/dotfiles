return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      ---group = "[X] Trouble",
      {
        "<leader>ox",
        function()
          require("trouble").toggle("diagnostics_preview")
        end,

        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>oo",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "[O]pen [O]utline",
      },
    },
    opts = {
      focus = true,
      keys = {
        ["<c-p>"] = "prev",
        ["<c-n>"] = "next",
      },
      modes = {
        diagnostics_preview = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
  }
}
