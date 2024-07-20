#!/usr/bin/lua

return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup()

    require('mason-null-ls').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {},
    }

    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.hover.printenv,
      },
      update_in_insert = true,
    }
  end,
}
