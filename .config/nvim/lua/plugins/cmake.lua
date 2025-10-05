table.insert(vim.g.linters, "cmake_lint")
return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      neocmake = {
        cmd = { "neocmakelsp", "--stdio" },
        single_file_support = true, -- suggested
        init_options = {
          format = {
            enable = true, -- to use lsp format
          },
          lint = {
            enable = true
          },
          semantic_token = false,
        },
        filetypes = { "cmake", "CMakeLists.txt", },
      },
    },
  }
}
