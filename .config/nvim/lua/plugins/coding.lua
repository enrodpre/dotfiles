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
    "madskjeldgaard/cppman.nvim",
    depedencies = {
      { "MunifTanjim/nui.nvim" },
    },
    keys = {
      "<leader>ok",
      "<leader>fk",
    },
    config = function()
      local cppman = require("cppman")
      cppman.setup()

      -- Make a keymap to open the word under cursor in CPPman
      vim.keymap.set("n", "<leader>ok", function()
        cppman.open_cppman_for(vim.fn.expand("<cword>"))
      end)

      -- Open search box
      vim.keymap.set("n", "<leader>fk", function()
        cppman.input()
      end)
    end,
  },
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   lazy = true,
  --   init = function()
  --     local loaded = false
  --     local function check()
  --       local cwd = vim.uv.cwd()
  --       if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
  --         require("lazy").load({ plugins = { "cmake-tools.nvim" } })
  --         loaded = true
  --       end
  --     end
  --     check()
  --     vim.api.nvim_create_autocmd("DirChanged", {
  --       callback = function()
  --         if not loaded then
  --           check()
  --         end
  --       end,
  --     })
  --   end,
  --   opts = {},
  -- },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>ad",
        function()
          require("neogen").generate()
        end,
        desc = "[A]pply [D]oc Generation",
      },
    },
    config = true,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      ---group = "[X] Trouble",
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
      modes = {
        diagnostics = { auto_open = true },
      },
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
