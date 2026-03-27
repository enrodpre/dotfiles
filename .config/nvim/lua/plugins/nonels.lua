return {
  "jay-babu/mason-null-ls.nvim",
  enable = false,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    local nonels = require("null-ls")
    local opts = {
      sources = {
        -- nonels.builtins.formatting.stylua,
        -- nonels.builtins.diagnostics.selene,
        nonels.builtins.diagnostics.zsh,
        nonels.builtins.hover.printenv,
        nonels.builtins.formatting.shfmt.with({
          filetypes = { "zsh", "bash", "sh" },
        }),
        nonels.builtins.formatting.shellharden.with({
          filetypes = { "zsh", "bash", "sh" },
        }),
        nonels.builtins.formatting.yamlfmt,
        nonels.builtins.code_actions.impl,
        nonels.builtins.diagnostics.cppcheck,
        nonels.builtins.diagnostics.pylint,
        nonels.builtins.formatting.biome,
      },
    }
    require("null-ls").setup(opts)
    require("mason-null-ls").setup({
      ensure_installed = nil,
      automatic_installation = true,
    })
  end,
}
