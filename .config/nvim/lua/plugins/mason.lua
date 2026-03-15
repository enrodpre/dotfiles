return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  lazy = true,
  opts = { ensure_installed = Config.lsp_servers() },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
