local function dap()
  return require("dap")
end



vim.g.dap_enabled = false
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    cond = vim.g.dap_enabled,
    opts = function()
      vim.fn.sign_define('DapStopped', {
        text = '',
        texthl = 'Error',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapBreakpoint', {
        text = '●',
        texthl = 'Error',
        linehl = '',
        numhl = ''
      })
      require("which-key").add({
        {
          "<leader>db",
          function() dap().toggle_breakpoint() end,
          desc = "Toggle Breakpoint",
        },
        {
          "<leader>dc",
          function() dap().continue() end,
          desc = "Continue",
        },
        {
          "<leader>dC",
          function() dap().run_to_cursor() end,
          desc = "Run to Cursor",
        },
        {
          "<leader>dT",
          function() dap().terminate() end,
          desc = "Terminate",
        }
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    cond = vim.g.dap_enabled,
    opts = function()
      if not vim.g.dap_enabled then return {} end

      local dapui = require("dapui")
      dap().listeners.before['attach']['dapui'] = function()
        vim.print("Attached")
        dapui.open()
      end
      dap().listeners.before['launch']['dapui'] = function()
        vim.print("Launched")
        dapui.open()
      end
      dap().listeners.before.event_terminated.dapui_config = function()
        vim.print("Terminated")
        dapui.close()
      end
      dap().listeners.before.event_exited.dapui_config = function()
        vim.print("Terminated")
        dapui.close()
      end
      require("which-key").add({ "<leader>dt", function() require "dapui".toggle() end, { desc = "[D]ap [T]oggle ui" } })

      return {}
    end
  },
}
