#!/usr/bin/lua

return {
   "nvimtools/none-ls.nvim",
   enabled = true,
   dependencies = {
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim", {
      "ThePrimeagen/refactoring.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-treesitter/nvim-treesitter",
      },
      config = function(_) require("refactoring").setup() end,
   },
   },
   config = function()
      require("mason").setup()

      require("mason-null-ls").setup {
         ensure_installed = {
            -- "mypy", "zsh", "shellcheck", "black",
            -- "prettier", "beautysh", "shellcheck",
            -- "shfmt", "yamlfmt",
         },
         automatic_installation = true,
         handlers = {},
      }

      local null_ls = require("null-ls")
      null_ls.setup {
         sources = {
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.hover.printenv,
            null_ls.builtins.diagnostics.pyproject_flake8,
            null_ls.builtins.diagnostics.flake8,
         },
      }
   end,
}
