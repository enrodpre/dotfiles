#!/usr/bin/lua


return {
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "neovim/nvim-lspconfig",

         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",

         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-cmdline",
         "ray-x/cmp-treesitter",
         "chrisgrieser/cmp-nerdfont",
         "roobert/tailwindcss-colorizer-cmp.nvim",
         "rafamadriz/friendly-snippets",
         "onsails/lspkind-nvim",
      },
      event = "VeryLazy",
      config = require("plugins.cmp.config"),
   },
}
