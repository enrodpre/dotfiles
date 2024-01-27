return {
  { "dbeniamine/cheat.sh-vim", cmd = "Cheat" },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "kj" },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = "<Esc>",
      })
    end,
  },
  {
    'lambdalisue/suda.vim',
    event = 'VeryLazy',
    config = function()
      vim.g.suda_smart_edit = true
    end
  },
  -- {
  --   "ggandor/leap.nvim",
  --   config = function()
  --     require('leap').create_default_mappings()
  --   end
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    dependencies = {
      "hrsh7th/nvim-cmp"
    },
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = true,
    },
  },
}
