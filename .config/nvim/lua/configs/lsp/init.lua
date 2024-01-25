return {
  bashls = {
    filetypes = {
      "sh",
      "zsh",
      "bash",
    }
  },
  html = { filetypes = { 'html', 'twig', 'hbs' } },
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
  pyright = require('configs.lsp.pyright'),
  ruff_lsp = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}
