#!/usr/bin/lua

return {
   {
      "williamboman/mason.nvim",
      opts = {
         ui = {
            icons = {
               package_installed = "✓",
               package_pending = "➜",
               package_uninstalled = "✗",
            },
         },
      },
   },
   {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile", },
      dependencies = {
         "williamboman/mason.nvim",
      },
   },
   {
      "jay-babu/mason-nvim-dap.nvim",
      keys = {
         "<leader>b",
         "<leader>B",
      },
      dependencies = {
         "williamboman/mason.nvim",
         "mfussenegger/nvim-dap",
      },
      opts = {
         ensure_installed = { "python", },
      },
   },
}
