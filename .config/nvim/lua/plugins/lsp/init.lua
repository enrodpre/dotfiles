#!/usr/bin/lua

return {
   "neovim/nvim-lspconfig",
   -- event="VeryLazy",
   dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
   },
   config = function()
      local servers = require("plugins.lsp.servers")
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
         "force",
         {},
         vim.lsp.protocol.make_client_capabilities(),
         has_cmp and cmp_nvim_lsp.default_capabilities() or {}
      )

      capabilities.textDocument.foldingRange = {
         dynamicRegistration = false,
         lineFoldingOnly = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
         callback = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
               buf = bufnr,
               callback = function()
                  vim.lsp.buf.format {
                     bufnr = bufnr,
                  }
               end,
            })
            local lsp_mapping = require("keys").lsp
            require("which-key").register(lsp_mapping)
         end,
         -- So it only executes once
         once = true,
      })

      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup {
         ensure_installed = vim.tbl_keys(servers),
         handlers = {
            function(server_name)
               require("lspconfig") [server_name].setup {
                  capabilities = capabilities,
                  settings = servers [server_name],
                  filetypes = (servers [server_name] or {}).filetypes,
               }
            end,
         },
      }

      vim.lsp.set_log_level("warn")
   end,

}
