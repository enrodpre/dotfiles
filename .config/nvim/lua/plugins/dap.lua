return {
  {
    'jay-babu/mason-nvim-dap.nvim',

    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        "python", "bash",
      },

    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
        'mfussenegger/nvim-dap',
      }
    },
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        'rcarriga/nvim-dap-ui',

        "theHamsta/nvim-dap-virtual-text",

        'jbyuki/one-small-step-for-vimkind',
      },
      ft = "python",
      config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

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

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        dap.configurations.lua = {
          {
            type = 'nlua',
            request = 'attach',
            name = "Attach to running Neovim instance",
          }
        }

        dap.adapters.nlua = function(callback, config)
          callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
        end

        require('dap-python').setup("/usr/bin/python3")
      end,
    }
  }
}
