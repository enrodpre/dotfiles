return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>cc", ":Telescope <CR>", mode = 'n', desc = "Open telescope" },
      {
        "<leader>ck", ":Telescope keymaps <CR>", mode = 'n', desc = "Open keymaps"
      },
    },
  },
  { "nvim-lua/plenary.nvim" },
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
  {
    "ggandor/leap.nvim",

  },
}
