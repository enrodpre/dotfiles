#!/usr/bin/lua

return {
   "nvimtools/none-ls.nvim",
   enabled = true,
   event = "VeryLazy",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
         "ThePrimeagen/refactoring.nvim",
         dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
         },
         config = true,
      },
   },
   config = function()
      require("mason").setup()

      require("mason-null-ls").setup {
         ensure_installed = {
            --"shfmt", -- "mypy", "zsh", "shellcheck", "black",
            -- "prettier", "beautysh", "shellcheck",
            -- , "yamlfmt",
         },
         automatic_installation = true,
         handlers = {},
      }

      local null_ls = require("null-ls")
      null_ls.setup {
         sources = {
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.hover.printenv,
            null_ls.builtins.formatting.shfmt.with({
               filetypes = { "sh", "bash", "zsh", },
               extra_args = { "-i", "4", },
            }),
         },
      }
   end,
}
