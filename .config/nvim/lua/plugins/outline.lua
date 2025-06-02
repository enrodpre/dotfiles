return {
  "stevearc/aerial.nvim",
  keys = { {
    "<leader>oa", "<cmd>AerialToggle!<CR>", "Toggle aerial"
  } },
  opts = {
    layout = {
      min_width = 40,
      max_width = { 70, 0.2 },
    },
    on_attach = function(bufnr)
      local wk = require("which-key")
      wk.add({ "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, }, })
      wk.add({ "}", "<cmd>AerialNext<CR>", { buffer = bufnr, }, })
    end,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
