local M = {
  { "folke/neodev.nvim", config = function() end },
  {
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta" },
    ft = "lua",
    opts = function(_, opts)
      opts.library = opts.library or {}
      table.insert(opts.library, {
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
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {
      keys = {
        ["<c-p>"] = "prev",
        ["<c-n>"] = "next",
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "LspAttach",
    opts = {
      mappings = {
        comment = "<leader>c",
        comment_line = "<leader>cc",
        comment_visual = "<leader>c",
        textobject = "<leader>c",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-plenary",
    },
    opts = {
      adapters = {
        vim.lua.lazyreq.on_index("neotest-plenary"),
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      vim.lua.fn.lazy_load_extension("refactoring")
    end,
    opts = {
      prompt_func_return_type = {
        cpp = true,
        c = true,
        h = true,
        hpp = true,
      },
      prompt_func_param_type = {
        cpp = true,
        c = true,
        h = true,
        hpp = true,
      },
    },
  },
}

return M
