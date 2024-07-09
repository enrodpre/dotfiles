return {
   {
      "norcalli/nvim-colorizer.lua",
      event = "VeryLazy",
      opts = {
         "*",
      },
   },
   {
      "echasnovski/mini.animate",
      enabled = false,
      version = false,
      config = true,
   },
   {
      "rcarriga/nvim-notify",
      event = "VeryLazy",
      opts = {
         timeout = 3000,
         max_height = function() return math.floor(vim.o.lines * 0.75) end,
         max_width = function() return math.floor(vim.o.columns * 0.75) end,
         on_open = function(win)
            vim.api.nvim_win_set_config(win, {
               zindex = 100,
            })
         end,
      },
   },
   {
      "rktjmp/lush.nvim",
      enabled = false,
      cmd = "LushRunTutorial",
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "VeryLazy",
      main = "ibl",
      opts = {
         indent = { char = "│", tab_char = "│", },
         scope = { enabled = false, },
         exclude = {
            filetypes = {
               "help", "alpha", "dashboard",
               "neo-tree", "Trouble", "trouble",
               "lazy", "mason", "notify",
               "toggleterm", "lazyterm",
            },
         },
      },
   },
   {
      "echasnovski/mini.indentscope",
      event = "VeryLazy",
      opts = {
         symbol = "│",
         options = { try_as_border = true, },
      },
      init = function()
         vim.api.nvim_create_autocmd("FileType", {
            pattern = {
               "help", "alpha", "dashboard",
               "neo-tree", "Trouble", "trouble",
               "lazy", "mason", "notify",
               "toggleterm", "lazyterm",
            },
            callback = function()
               vim.b.miniindentscope_disable = true
            end,
         })
      end,
   },
   {
      "richardbizik/nvim-toc",
      event = "VeryLazy",
      config = true,
      enabled = false,
   },
   {
      "catppuccin/nvim",
      event = "UiEnter",
      config = function() vim.cmd [[colorscheme catppuccin]] end,
      name = "catppuccin",
      opts = {
         flavour = "mocha",
         integrations = {
            cmp = true,
            dap = true,
            gitsigns = true,
            indent_blankline = { enabled = true, },
            mason = true,
            markdown = true,
            mini = {
               enabled = true,
            },
            native_lsp = {
               enabled = true,
               underlines = {
                  errors = { "undercurl", },
                  hints = { "undercurl", },
                  warnings = { "undercurl", },
                  information = { "undercurl", },
               },
            },
            navic = { enabled = true, custom_bg = "lualine", },
            neotest = true,
            noice = false,
            notify = true,
            semantic_tokens = true,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ufo = true,
            which_key = true,
         },
      },
   },
}
