#!/usr/bin/lua

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },
  keys = require("plugins.lsp.mapping"),
  opts = {
    diagnostic = {
      underline = true,
      update_in_insert = true,
      severity_sort = true,
      icons = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      },
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
    },
    document_highlight = { enabled = false },
    inlay_hints = {
      enabled = false,
    },
    servers = {
      bashls = { filetypes = { "sh", "zsh", "bash" } },
      clangd = {
        keys = {
          { "gdh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require("lspconfig.util").find_git_ancestor(
            fname
          )
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      cssls = { filetypes = "rasi" },
      html = { filetypes = { "html", "twig", "hbs" } },
      jsonls = {},
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
    for name, icon in pairs(opts.diagnostic.icons) do
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end

    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if opts.inlay_hints.enabled and inlay_hint then
      vim.lua.fn.on_attach(function(client, buffer)
        if client.supports_method("textDocument/inlayHint") then
          inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    if type(opts.diagnostic.virtual_text) == "table" and opts.diagnost then
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
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {}
    )

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function(args)
            require("conform").format({ bufnr = args.buf })
          end,
        })
      end,
      once = true,
    })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      -- ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      },
    })

    vim.lsp.set_log_level("warn")
  end,
}
