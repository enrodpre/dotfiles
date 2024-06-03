return
{
   {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
         library = {
            -- Library items can be absolute paths
            -- "~/projects/my-awesome-lib",
            -- Or relative, which means they will be resolved as a plugin
            -- "LazyVim",
            -- When relative, you can also provide a path to the library in the plugin dir
            "luvit-meta/library", -- see below
         },
      },
   },
   { "Bilal2453/luvit-meta", lazy = true, }, -- optional `vim.uv` typings
   { "tpope/vim-sleuth",     event = "BufReadPre", },
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
      "numToStr/Comment.nvim",
      event = "VeryLazy",
      opts = {
         toggler = {
            line = "<leader>cc",
            block = "<leader>cbc",
         },
         opleader = {
            line = "<leader>c",
            block = "<leader>cb",
         },
         extra = {
            above = "<leader>cO",
            below = "<leader>cbo",
            eol = "<leader>cA",
         },
      },
   },
   {
      "nvim-neotest/neotest",
      enabled = false,
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-neotest/neotest-python",
         "nvim-neotest/neotest-plenary",
         "nvim-neotest/nvim-nio",
      },
      opts = {
         adapters = function()
            return require("neotest-python")({
               runner = "pytest",
            })
         end,
      },
   },
}
