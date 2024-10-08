#!/usr/bin/lua

local M = {
  {
    "ranjithshegde/ccls.nvim",
    event = "LazyFile",
    opts = {
      lsp = {
        init_options = {
          compilationDatabaseDirectory = "build",
        },
        server = {
          offset_encoding = "utf-8",
          -- cmd = { "ccls", "--gcc-toolchain=/usr" },
        },
        disable_capabilities = {
          completionProvider = true,
          documentFormattingProvider = true,
          documentRangeFormattingProvider = true,
          documentHighlightProvider = true,
          documentSymbolProvider = true,
          workspaceSymbolProvider = true,
          renameProvider = true,
          hoverProvider = true,
          codeActionProvider = true,
        },
        disable_diagnostics = true,
        disable_signature = true,
        codelens = { enable = true },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      -- {
      --   "williamboman/mason-lspconfig.nvim",
      -- },
    },
    event = "LazyFile",
    keys = require("plugins.lsp.mapping"),
    opts = {
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      diagnostic = {
        -- icons = vim.config.icons.diagnostic,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      },
      document_highlight = { enabled = true },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        bashls = { filetypes = { "sh", "zsh", "bash" } },
        clangd = {
          cmd = {
            "clangd",
            "--enable-config",
            "--background-index",
            "-j 4",
            "--pretty",
            "--header-insertion=iwyu",
            "--import-insertions",
            "--clang-tidy",
            "--limit-references=0",
            "--completion-style=detailed",
          },
          init_options = {
            usePlaceholders = false,
            completeUnimported = true,
            clangdFileStatus = true,
            semanticHighlighting = true,
            -- Increase the timeout for semantic tokens
            semanticTokens = {
              -- Adjust the timeout value as needed
              timeout = 5000, -- Example: 5000 ms
            },
          },
        },
        cssls = { filetypes = { "rasi" } },
        lua_ls = {
          Lua = {
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
            -- diagnostics = {
            --   globals = { "safereq", "lazyreq" },
            -- },
            -- semantoc = { enable = false },
          },
        },
        pylsp = {
          plugins = {
            rope_autoimport = { enabled = true },
          },
        },
        yamlls = {},
      },
    },
    config = function(_, opts)
      -- for name, icon in pairs(opts.diagnostic.icons) do
      --   name = "DiagnosticSign" .. name
      --   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      -- end

      -- local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      --
      -- if opts.inlay_hints.enabled and inlay_hint then
      --   vim.lua.on_attach(function(client, buffer)
      --     if client.supports_method("textDocument/inlayHint") then
      --       inlay_hint.enable(true, { bufnr = buffer })
      --     end
      --   end)
      -- end

      if type(opts.diagnostic.virtual_text) == "table" and opts.diagnostic.virtual_text.prefix == "icons" then
        opts.diagnostic.virtual_text.prefix = function(diagnostic)
          local icons = opts.diagnostic.icons
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostic))

      local servers = opts.servers or {}
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = true,
      --   lineFoldingOnly = true,
      -- }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function(args)
              require("conform").format({ bufnr = args.buf })
            end,
          })
        end,
        once = true,
      })
      -- capabilities.textDocument.semanticTokens = false
      -- capabilities.textDocument.inlayHint = false
      -- capabilities.workspace.inlayHint.refreshSupport = false
      -- capabilities.workspace.inlayHint.refreshSupport = false

      require("mason").setup()

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })

      vim.lsp.set_log_level("warn")
    end,
  },
}

local extensions = require("plugins.lsp.extensions")
for _, ext in ipairs(extensions) do
  table.insert(M, ext)
end

return M
