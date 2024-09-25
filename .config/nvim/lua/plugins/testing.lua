local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-plenary",
  },
  opts = {
    adapters = {
      vim.lua.lazyreq.on_index("neotest-plenary"),
    },
  },

  {
    "nvim-neotest/neotest-python",
    dependencies = {
      "nvim-neotest/neotest",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/nvim-nio",
    },
    ft = "python",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
            dap = { justMyCode = false },
          }),
        },
      })
    end,
  },
}

return vim.g.enable.testing and M or {}
