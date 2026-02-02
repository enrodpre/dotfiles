return {
  {
    "folke/lazydev.nvim",
    dependencies = {
      "Bilal2453/luvit-meta",
      "neovim/nvim-lspconfig"
    },
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "lazy.nvim", },
        { "nvim-dap-ui" },
      }
    }
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        }
      },
    }
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
          require "osv".launch { port = 8086 }
        end,
        ft = "lua",
        desc = "Launch current Neovim process onto 8086",
      },--foreground
    },
    opts = function()
      local dap = require "dap"
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance"
        },--foreground
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end

      return {}
    end,
  },
}
