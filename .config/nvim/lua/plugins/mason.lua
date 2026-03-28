return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  opts = {
    automatic_enable = true,
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
