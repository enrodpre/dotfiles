local lazycmp = vim.lua.lazyreq.on_exported_call 'cmp'
local lazydap = vim.lua.lazyreq.on_exported_call 'dap'
local lazydapui = vim.lua.lazyreq.on_exported_call 'dapui'

return {
  {
    'jay-babu/mason-nvim-dap.nvim',
    enabled = false,
    keys = {
      '<leader>b',
      '<leader>B',
      {
        '<leader>sb',
        function()
          lazydap.toggle_breakpoint()
        end,
        desc = '[S]et Toggle Breakpoint',
      },
      {
        '<leader>sB',
        function()
          lazydap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[S]et Conditional Breakpoint',
      },
      {
        '<F1>',
        function()
          lazydap.step_into()
        end,
        'Debug: Step Into',
      },
      {
        '<F2>',
        function()
          lazydap.step_out()
        end,
        'Debug: Step Out',
      },
      {
        '<F3>',
        function()
          lazydap.step_over()
        end,
        'Debug: Step Over',
      },
      {
        '<F5>',
        function()
          lazydap.continue()
        end,
        'Debug: Start/Continue',
      },
    },
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'python',
        'bash',
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    keys = {
      {
        '<F7>',
        function()
          lazydapui.toggle()
        end,
        'Debug: See last session result.',
      },
    },
    dependencies = { 'nvim-neotest/nvim-nio' },
    config = function()
      local icons = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '*',
      }

      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      for name, sign in pairs(icons) do
        local sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
      end
    end,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      '<leader>b',
      '<leader>B',
      '<F5>',
    },
    dependencies = {
      'rcarriga/nvim-dap-ui',

      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      require('cmp').setup {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
        end,
      }

      require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })
    end,
  },
}
