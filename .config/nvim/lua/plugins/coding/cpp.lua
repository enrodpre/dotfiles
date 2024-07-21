return {

  -- Add C/C++ to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'c', 'cpp' })
      end
    end,
  },

  {
    'p00f/clangd_extensions.nvim',
    ft = 'cpp',
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = '',
        },
      },
    },
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   ft = 'cpp',
  --   opts = {
  --     sorting = {
  --       comparators = {
  --         vim.lua.lazyreq.on_exported_call 'clangd_extensions.cmp_scores',
  --       },
  --     },
  --   },
  -- },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Ensure C/C++ debugger is installed
      'williamboman/mason.nvim',
      opts = function(_, opts)
        if type(opts.ensure_installed) == 'table' then
          vim.list_extend(opts.ensure_installed, { 'codelldb' })
        end
      end,
    },
    opts = function()
      local dap = require 'dap'
      if not dap.adapters['codelldb'] then
        require('dap').adapters['codelldb'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'codelldb',
            args = {
              '--port',
              '${port}',
            },
          },
        }
      end
      for _, lang in ipairs { 'c', 'cpp' } do
        dap.configurations[lang] = {
          {
            type = 'codelldb',
            request = 'launch',
            name = 'Launch file',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'codelldb',
            request = 'attach',
            name = 'Attach to process',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
        }
      end
    end,
  },
}
