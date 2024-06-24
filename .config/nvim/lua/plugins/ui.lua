return {
   {
      "norcalli/nvim-colorizer.lua",
      event = "UiEnter",
      config = function() require("colorizer").setup() end,
   },
   {
      "folke/tokyonight.nvim",
      event = "UiEnter",
      config = function() vim.cmd [[colorscheme tokyonight]] end,
      opts = { style = "night", },
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons", },
      event = "VeryLazy",
      opts = {
         options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = "|",
            -- section_separators = "",
         },
         sections = {
            lualine_x = {
               "encoding",
               "filetype",
            },
         },
      },
   },
   {
      "echasnovski/mini.animate",
      enabled = false,
      version = false,
      config = true,
   },
   {
      "AlphaTechnolog/pywal.nvim",
      event = "UiEnter",
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
      lazy = true,
      name = "catppuccin",
      opts = {
         integrations = {
            aerial = true,
            alpha = true,
            cmp = true,
            dashboard = true,
            flash = true,
            gitsigns = true,
            headlines = true,
            illuminate = true,
            indent_blankline = { enabled = true, },
            leap = true,
            lsp_trouble = true,
            mason = true,
            markdown = true,
            mini = true,
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
            neotree = true,
            noice = true,
            notify = true,
            semantic_tokens = true,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            which_key = true,
         },
      },
   }, }
