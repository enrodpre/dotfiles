return {
  bashls = {
    filetypes = {
      "sh",
      "zsh",
      "bash",
    },
  },
  -- html = { filetypes = { 'html', 'twig', 'hbs' } },
  jsonls = {},
  lua_ls = {
    single_file_support = true,
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  pylsp = {
    plugins = {
      rope_autoimport = {
        enabled = true,
      }
    }
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
        customTags = { "!color", "!color" }
      },
    },
  },
}
