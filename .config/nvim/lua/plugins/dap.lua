local enabled = false
return {
   {
      "jay-babu/mason-nvim-dap.nvim",
      enabled = enabled,
      dependencies = {
         "williamboman/mason.nvim",
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
         enabled = enabled,
         "mfussenegger/nvim-dap-python",
         ft = "python",
         dependencies = {
            "mfussenegger/nvim-dap",
         },
      },
      {
         enabled = enabled,
         "mfussenegger/nvim-dap",
         dependencies = {
            "rcarriga/nvim-dap-ui",

            "theHamsta/nvim-dap-virtual-text",
            "jbyuki/one-small-step-for-vimkind",
         },
         ft = "python",
         config = function()
            local dap = require "dap"
            local dapui = require "dapui"

            -- Dap UI setup
            -- For more information, see |:help nvim-dap-ui|
            dapui.setup {
               -- Set icons to characters that are more likely to work in every terminal.
               --    Feel free to remove or use ones that you like more! :)
               --    Don't feel like these are good choices.
               icons = { expanded = "▾", collapsed = "▸", current_frame = "*", },
               controls = {
                  icons = {
                     pause = "⏸",
                     play = "▶",
                     step_into = "⏎",
                     step_over = "⏭",
                     step_out = "⏮",
                     step_back = "b",
                     run_last = "▶▶",
                     terminate = "⏹",
                     disconnect = "⏏",
                  },
               },
            }

            require("which-key").register(require("keys").dap())


            dap.listeners.after.event_initialized ["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated ["dapui_config"] = dapui.close
            dap.listeners.before.event_exited ["dapui_config"] = dapui.close

            dap.configurations.lua = {
               {
                  type = "nlua",
                  request = "attach",
                  name = "Attach to running Neovim instance",
               },
            }

            dap.adapters.nlua = function(callback, config)
               callback({
                  type = "server",
                  host = config.host or "127.0.0.1",
                  port =
                     config.port or 8086,
               })
            end

            require("dap-python").setup("/usr/bin/python3")
         end,
      },
   },
}
