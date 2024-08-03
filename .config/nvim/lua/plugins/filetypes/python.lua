#!/usr/bin/lua

return {
   {
      "linux-cultist/venv-selector.nvim",
      dependencies = {
         "neovim/nvim-lspconfig",
         "nvim-telescope/telescope.nvim",
      },
      ft = "python",
      enabled = false,
      opts = { name = ".venv", },
      -- event = "BufEnter *.py",
      config = function() require("venv-selector").setup {} end,
      -- }, {
      --   "wookayin/vim-autoimport",
      --   ft = "python",
      --   config = function()
      --     vim.api.nvim_set_keymap("n", "<leader>au", ":ImportSymbol<CR>", {})
      --   end,
      --   dev = true
   },
   {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
         "mfussenegger/nvim-dap",
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
         require("neotest").setup {
            adapters = {
               require("neotest-python")({
                  runner = "pytest",
                  dap = { justMyCode = false, },
               }),
            },
         }
      end,

   },
}
