return {
  {
    "stevearc/aerial.nvim",
    keys = {
      "<leader>oo", "<cmd>AerialToggle!<CR>",
    },
    opts = {
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
  },
}
