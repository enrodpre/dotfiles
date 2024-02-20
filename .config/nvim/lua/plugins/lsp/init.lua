#!/usr/bin/lua


return {
   "neovim/nvim-lspconfig",
   dependencies = {
      { "folke/neodev.nvim", opts = {}, },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
         "j-hui/fidget.nvim",
         -- enabled = false,
         opts = {},
      },
   },
   config = function()
      require("neodev").setup()
      local servers = require("plugins.lsp.servers")
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
         "force",
         {},
         vim.lsp.protocol.make_client_capabilities(),
         has_cmp and cmp_nvim_lsp.default_capabilities() or {}
      )

      vim.api.nvim_create_autocmd("LspAttach", {
         callback = require("plugins.lsp.on_attach"),
      })

      -- Ensure the servers above are installed
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup {
         ensure_installed = vim.tbl_keys(servers),
      }

      vim.lsp.set_log_level("warn")

      mason_lspconfig.setup_handlers {
         function(server_name)
            require("lspconfig")[server_name].setup {
               capabilities = capabilities,
               settings = servers[server_name],
               filetypes = (servers[server_name] or {}).filetypes,
            }
         end,
      }
   end,

}
