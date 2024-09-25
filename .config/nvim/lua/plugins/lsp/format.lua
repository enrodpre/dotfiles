#!/usr/bin/lua

return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim", },
  cmd = "ConformInfo",
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua", },
      sh = { "shfmt", },
      cpp = { "clang_format", },
      cmake = { "cmake_format", },
    },
    format_on_save = { timeout_ms = 500, lsp_format = "fallback", },
    formatters = {
      injected = { options = { ignore_errors = false, }, },
      shfmt = { prepend_args = { "-i", "4", "-ci", }, },
    },
  },
}
