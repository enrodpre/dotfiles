#!/usr/bin/lua

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  keys = require 'plugins.lsp.mapping',
  opts = {
    autoformat = true,
    capabilities = {},
    diagnostic = {
      underline = true,
      update_in_insert = true,
      severity_sort = true,
      icons = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      },
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        -- prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        prefix = 'icons',
      },
    },
    document_highlight = { enabled = false },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    format_notify = false,
    inlay_hints = {
      enabled = false,
    },
    servers = {
      bashls = { filetypes = { 'sh', 'zsh', 'bash' } },
      clangd = {
        keys = {
          { 'gs', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
        },
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      cssls = { filetypes = 'rasi' },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      jsonls = {},
      pylsp = {
        plugins = {
          rope_autoimport = { enabled = true },
        },
      },
      vimls = {},
    },
  },
  config = function(_, opts)
    for name, icon in pairs(opts.diagnostic.icons) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end

    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if opts.inlay_hints.enabled and inlay_hint then
      vim.lua.fn.on_attach(function(client, buffer)
        if client.supports_method 'textDocument/inlayHint' then
          inlay_hint(buffer, true)
        end
      end)
    end

    if type(opts.diagnostic.virtual_text) == 'table' and opts.diagnostic.virtual_text.prefix == 'icons' then
      opts.diagnostic.virtual_text.prefix = vim.fn.has 'nvim-0.10.0' == 0 and '●'
        or function(diagnostic)
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
    local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {}
    )

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(client, bufnr)
        vim.lua.fn.load_keymap 'lsp'
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function(args)
            require('conform').format { bufnr = args.buf }
          end,
        })
      end,
      once = true,
    })

    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      -- ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      },
    }

    vim.lsp.set_log_level 'warn'
  end,
}
