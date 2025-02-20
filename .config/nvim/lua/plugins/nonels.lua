#!/usr/bin/lua

return {
  "nvimtools/none-ls.nvim",
  enabled = true,
  lazy = false,
  event = "LspAttach",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = "williamboman/mason.nvim",
    },
    {
      "ckolkey/ts-node-action",
      dependencies = { "nvim-treesitter", },
      opts = {},
    },
  },
  config = function()
    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = {},
      automatic_installation = true,
      handlers = {},
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.refactoring,
        -- null_ls.builtins.code_actions.proselint,
        -- null_ls.builtins.code_actions.ts_node_action,
        null_ls.builtins.diagnostics.cppcheck.with({
          extra_args = { "--cppcheck-build-dir=/tmp/cppcheck", "--project=compile_commands.json", },
        }),
        -- null_ls.builtins.diagnostics.gccdiag,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.hover.printenv,
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci", },
        }),
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.cmake_format,

      },
      update_in_insert = true,
    })
  end,
}
