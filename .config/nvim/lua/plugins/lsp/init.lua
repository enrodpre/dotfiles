#!/usr/bin/lua

local M = {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = { ui = { icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    } } },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
  require("plugins.lsp.lspconfig"),
  require("plugins.lsp.nonels"),
  require("plugins.lsp.format"),
  {
  'Civitasv/cmake-tools.nvim',
  init = function()
    local loaded = false
    local function check()
      local cwd = vim.uv.cwd()
      if vim.fn.filereadable(cwd .. '/CMakeLists.txt') == 1 then
        require('lazy').load { plugins = { 'cmake-tools.nvim' } }
        loaded = true
      end
    end
    check()
    vim.api.nvim_create_autocmd('DirChanged', {
      callback = function()
        if not loaded then
          check()
        end
      end,
    })
  end,
  opts = {},
  },
}

return M
