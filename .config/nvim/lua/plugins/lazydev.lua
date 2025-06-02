return {
  "folke/lazydev.nvim",
  dependencies = {
    "Bilal2453/luvit-meta",
    "neovim/nvim-lspconfig"
  },
  ft = "lua",
  opts = {
    "lazy.nvim",
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    "neodev.nvim/types/stable",
  }
}
