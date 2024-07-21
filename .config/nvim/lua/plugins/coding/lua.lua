#!/usr/bin/lua

return {
  { "folke/neodev.nvim", config = function() end },
  {
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta" },
    ft = "lua",
    opts = function(_, opts)
      opts.library = opts.library or {}
      table.insert(opts.library, {
        "luvit-meta",
        "lazy.nvim",
        "neodev.nvim/types/stable",
      })
      return opts
    end,
  },
  {
    "danymat/neogen",
    config = true,
    keys = { "<leader>n" },
  },
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
}
