return {
  bashls = { filetypes = { "sh", "zsh", "bash" } },
  -- html = { filetypes = { 'html', 'twig', 'hbs' } },
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
        format = { enable = false },
        completion = { callSnippet = "Replace" },
        hint = { enable = true },
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  pylsp = {
    plugins = {
      rope_autoimport = { enabled = true },
    },
  },
  -- ruff_lsp = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        hover = true,
        format = {
          enable = true,
          singleQuote = true,
        },
        completion = true,
        validate = true,
        customTags = { "!color", "!color" },
      },
    },
  },
}
