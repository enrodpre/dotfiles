return {
  cmd = {
    "clangd",
    "--enable-config",
    "--background-index",
    "-j", "12",
    "--malloc-trim",
    "--clang-tidy",
    "--pch-storage=disk",
    "--pretty",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--completion-style=detailed",
    "--all-scopes-completion",
  },
  filetypes = { "cpp", "hpp", "inl", },
  init_options = {
    clangdFileStatus = true,
    semanticTokens = {
      timeout = 5000,
    },
  },
}
