#!/usr/bin/lua

local M = {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
  require 'plugins.lsp.lspconfig',
  require 'plugins.lsp.nonels',
  require 'plugins.lsp.format',
}

return M
