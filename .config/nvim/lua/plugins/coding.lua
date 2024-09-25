local M = {
  { "folke/neodev.nvim", config = function() end, enabled = false },
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
    keys = { "<leader>c" },
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
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    enabled = false,
    opts = { name = ".venv" },
    config = function()
      require("venv-selector").setup({})
    end,
  },
}

return M
