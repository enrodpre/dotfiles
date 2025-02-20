return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  ft = "python",
  opts = { name = ".venv", },
  config = function()
    require("venv-selector").setup({})
  end,
  branch = "regexp",
}
