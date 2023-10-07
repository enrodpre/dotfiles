local function generate_sources()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local b = null_ls.builtins

  local sources = {
    b.code_actions.refactoring,
    b.code_actions.gitsigns,
    b.code_actions.shellcheck,

    b.completion.luasnip,

    b.formatting.stylua,
    b.formatting.ruff,

    b.diagnostics.zsh,
    b.diagnostics.ruff,
    b.diagnostics.gitlint,
    b.diagnostics.selene,
    b.diagnostics.shellcheck,
    b.diagnostics.spectral,
    b.diagnostics.vulture,
    b.diagnostics.yamllint,

    b.hover.printenv,
    b.hover.dictionary,

    b.formatting.autoflake,
    b.formatting.autopep8,
    b.formatting.beautysh,
    b.formatting.stylua,
    b.formatting.reorder_python_imports,
    b.formatting.shellharden,
    b.formatting.shfmt,
    b.formatting.yamlfix,
    b.formatting.yamlfmt,
  }

  return sources
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  else
  end
end

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("null-ls").setup({
        sources = generate_sources(),
        on_attach = on_attach,
      })
    end,
  }
}
