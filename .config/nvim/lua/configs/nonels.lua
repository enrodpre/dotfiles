#!/usr/bin/lua

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.yamlfmt,
  },
})

require("mason-null-ls").setup {
  ---@diagnostic disable-next-line: assign-type-mismatch
  ensure_installed = nil,
  automatic_installation = true,
}
