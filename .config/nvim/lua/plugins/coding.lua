return {
  {
    "L3MON4D3/LuaSnip",
    opts = { run = "make install_jsregexp" }
  },
  { "tmhedberg/SimpylFold" },
  { "mfussenegger/nvim-dap" },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").test_runner = "pytest"
    end,
  },
  --"jbyuki/one-small-step-for-vimkind",
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufEnter *.py", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  {
    "nvim-neotest/neotest",
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
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true
  },
  {
    "windwp/nvim-autopairs",
    dependencies = {
      "hrsh7th/nvim-cmp"
    },
    event = "InsertEnter",
    -- config = function()
    --   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    --   local cmp = require('cmp')
    --   cmp.event:on(
    --     'confirm_done',
    --     cmp_autopairs.on_confirm_done()
    --   )
    -- end,
    opts = {
      enable_check_bracket_line = true,
    },
  },
}
