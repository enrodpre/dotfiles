return {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "stylua",
          "lua-language-server",
          "luacheck",
          "shellcheck",
          "vim",
          "shfmt",
          "bash-language-server",
          "ruff-lsp",
        },
        automatic_installation = true,
      }
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "cssls",
          "html",
          "denols",
          "bashls",
          -- "pylsp",
          "pyright",
          "jdtls",
        }
      },
      automatic_installation = true,
    }
