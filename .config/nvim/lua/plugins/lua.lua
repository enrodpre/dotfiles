return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        -- { path = "snacks.nvim",        words = { "Snacks" } },
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- "nvim-dap-ui",
      },
      integrations = { cmp = false },
      debug = true

    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jbyuki/one-small-step-for-vimkind",
    },
    keys = {
      {
        "<leader>dl",
        function()
          require("osv").launch({ port = 8086 })
        end,
        ft = "lua",
        desc = "Launch current Neovim process onto 8086",
      }, --foreground
    },
    opts = function()
      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        }, --foreground
      }

      dap.adapters.nlua = function(callback, config)
        callback({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or 8086,
        })
      end

      return {}
    end,
  },
}
