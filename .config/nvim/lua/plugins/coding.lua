return
{
   { "tpope/vim-sleuth", event = "BufReadPre", },
   {
      "linux-cultist/venv-selector.nvim",
      dependencies =
      {
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
      "numToStr/Comment.nvim",
      event = "VeryLazy",
      opts =
      {
         toggler =
         {
            line = "<leader>cc",
            block = "<leader>cbc",
         },
         opleader =
         {
            line = "<leader>c",
            block = "<leader>cb",
         },
         extra =
         {
            above = "<leader>cO",
            below = "<leader>cbo",
            eol = "<leader>cA",
         },
      },
   },
   {
      "nvim-neotest/neotest",
      enabled = true,
      dependencies =
      {
         "nvim-lua/plenary.nvim",
         "nvim-neotest/neotest-python",
         "nvim-neotest/neotest-plenary",
      },
      config = function()
         require("neotest").setup(
            {
               adapters =
               {
                  require("neotest-python")(
                     {
                        runner = "pytest",
                     }),
               },
            })
      end,
   },
}
