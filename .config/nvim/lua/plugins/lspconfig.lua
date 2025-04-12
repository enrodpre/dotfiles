local mapping = {
  {
    "gl",
    group = "[G]o [L]sp",
  },
  {
    {
      "<leader>wd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "[W]orkspace [D]iagnostics",
    },
    {
      "<leader>wa",
      vim.lsp.buf.add_workspace_folder,
      desc = "[W]orkspace [A]dd Folder",
    },
    {
      "<leader>wr",
      vim.lsp.buf.remove_workspace_folder,
      desc = "[W]orkspace [R]emove Folder",
    },
    {
      "<leader>wl",
      function()
        vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = "[W]orkspace [L]ist Folders",
    },
    {
      "<leader>ws",
      function(...)
        require("telescope").lsp_dynamic_workspace_symbols(...)
      end,
      desc = "[W]orkspace [S]ymbols",
    },
  },
  {
    "gd",
    group = "[G]o [D]ocument",
  },
  {
    "gdd",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "[G]o [D]ocument [D]iagnostics",
  },
  {
    "<leader>ac",
    function()
      vim.lsp.buf.code_action({ apply = true, })
    end,
    desc = "[A]pply [C]ode Action",
  },
  {
    "gdh",
    "<cmd>ClangdSwitchSourceHeader<CR>",
    desc = "Change between header and source",
  },
  {
    "<leader>od",
    vim.diagnostic.open_float,
    desc = "[O]pen Dianostic",
  },
  {
    "<leader>oi",
    vim.lsp.buf.incoming_calls,
    desc = "[O]pen incoming calls",
  },
  {
    "<leader>os",
    vim.lsp.buf.signature_help,
    desc = "[O]pen [S]ignature",
  },
  -- {
  --   "glD",
  --   vim.lsp.buf.declaration,
  --   desc = "[G]oto [D]eclaration",
  -- },
  -- {
  --   "gld",
  --   tb.lsp_definitions,
  --   desc = "[G]oto [D]efinition",
  -- },
  -- {
  --   "glr",
  --   tb.lsp_references,
  --   desc = "[G]oto [R]eferences",
  -- },
  -- {
  --   "gli",
  --   tb.lsp_implementations,
  --   desc = "[G]oto [I]mplementation",
  -- },
}


return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "shfmt",
            "clang_format",
            "cmake_format",
          },
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      { "williamboman/mason-lspconfig.nvim", },
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePre", },
    opts = {
      capabilities = {
        offsetEncoding = { "utf-16", },
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
          didChangeWatchedFiles = {
            dynamicRegistration = true,
            relative_pattern_support = true,
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

      servers = {
        bashls = { filetypes = { "sh", "zsh", "bash", }, },
        cmake = {
          filetypes = { "cmake", "CMakeLists.txt", },
        },
        neocmake = {
          filetypes = { "cmake", "CMakeLists.txt", },
        },
        jqls = {},
        clangd = {
          cmd = {
            "clangd",
            "--enable-config",
            "--background-index",
            "-j 12",
            "--query-driver=/usr/bin/g++",
            "--clang-tidy",
            "--pch-storage=memory",
            "--pretty",
            "--header-insertion=iwyu",
            "--import-insertions",
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
        cssls = { filetypes = { "rasi", }, },
        lua_ls = {
          Lua = {
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_", },
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
        yamlls = {},
      },
    },
    config = function(_, opts)
      -- require("java").setup()
      vim.diagnostic.config(vim.deepcopy(opts.diagnostic))
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )
      capabilities.textDocument.completion.completionItem.snippetSupport = true



      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Lsp mapping",
        once = true,
        callback = function()
          require("which-key").add(mapping)
          -- vim.lua_omnifunc()
          -- vim.lsp.inlay_hint.on_inlayhint(err, result?, ctx, _)
        end,
      })

      local venv_path = os.getenv('VIRTUAL_ENV')
      local py_path = nil
      -- decide which python executable to use for mypy
      if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
      else
        py_path = vim.g.python3_host_prog
      end

      require("lspconfig").pylsp.setup {
        settings = {
          pylsp = {
            plugins = {
              -- formatter options
              black = { enabled = true },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              -- linter options
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              -- type checker
              pylsp_mypy = { enabled = true, },
              -- auto-completion options
              jedi_completion = { fuzzy = false },
              -- import sorting
              pyls_isort = { enabled = true },
              rope_autoimport = {
                enabled = false,
              },
            },
          },
        },
        flags = {
          debounce_text_changes = 200,
        },
        capabilities = capabilities,
      }



      local handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            settings = opts.servers[server_name] or {},
            filetypes = (opts.servers[server_name] or {}).filetypes,
          }
        end,
      }

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = nil, --vim.tbl_keys(opts.servers),
        automatic_installation = false,
        handlers = handlers,
      })


      vim.lsp.set_log_level("warn")
    end,
  },
}
