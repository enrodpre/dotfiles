#!/usr/bin/lua

return {
  { "folke/neodev.nvim", config = function() end },
  {
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta" },
    ft = "lua",
    opts = {
      -- path = "luvit-meta/library",
      { "lazy.nvim" },
      -- words = { "vim%.uv" },
    },
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
    end,
  },
}
