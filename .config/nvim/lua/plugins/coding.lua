return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufEnter *.py", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  {
    "nathom/filetype.nvim"
  },
  {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
          }),
        },
      })
    end,
  },
}
