local lazycmp = vim.lua.lazyreq.on_exported_call("cmp")
local lazydap = vim.lua.lazyreq.on_exported_call("dap")
local lazydapui = vim.lua.lazyreq.on_exported_call("dapui")

return vim.g.enable.dap
  or {}
    and {
      {
        "jbyuki/one-small-step-for-vimkind",
        keys = { "<leader>d" },
        config = function(_, opts)
          local dap = require("dap")

          dap.adapters.nlua = function(callback, conf)
            local adapter = {
              type = "server",
              host = conf.host or "127.0.0.1",
              port = conf.port or 8086,
            }
            if conf.start_neovim then
              local dap_run = dap.run
              dap.run = function(c)
                adapter.port = c.port
                adapter.host = c.host
              end
              require("osv").run_this()
              dap.run = dap_run
            end
            callback(adapter)
          end

          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Run this file",
              start_neovim = {},
            },
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance (port = 8086)",
              port = 8086,
            },
          }
        end,
      },
      {
        "mfussenegger/nvim-dap",
        enabled = enabled,
        dependencies = {
          -- Ensure C/C++ debugger is installed
          "williamboman/mason.nvim",
          opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
              vim.list_extend(opts.ensure_installed, { "codelldb" })
            end
          end,
        },
        opts = function()
          local dap = require("dap")
          if not dap.adapters["codelldb"] then
            require("dap").adapters["codelldb"] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "codelldb",
                args = {
                  "--port",
                  "${port}",
                },
              },
            }
          end
          for _, lang in ipairs({ "c", "cpp" }) do
            dap.configurations[lang] = {
              {
                type = "codelldb",
                request = "launch",
                name = "Launch file",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
              },
              {
                type = "codelldb",
                request = "attach",
                name = "Attach to process",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
            }
          end
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = enabled,
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            "python",
            "bash",
            "lua",
          },
        },
        -- mason-nvim-dap is loaded when nvim-dap loads
        config = function() end,
      },
      {
        "mfussenegger/nvim-dap",
        enabled = enabled,
        dependencies = {
          "rcarriga/nvim-dap-ui",
          {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
          },
        },
    -- stylua: ignore
    keys = {
       {'<leader>d'},
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>da',
        function()
          require('dap').continue { before = get_args }
        end,
        desc = 'Run with Args',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to Line (No Execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
        config = function()
          vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

          for name, sign in pairs(require("config.defaults").icons.dap) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
          end
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        enabled = enabled,
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
        },
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
    }
