local noice_config = function(opts)
   local focused = true

   vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
         focused = true
      end,
   })
   vim.api.nvim_create_autocmd("FocusLost", {
      callback = function()
         focused = false
      end,
   })

   table.insert(opts.routes or {}, 1, {
      filter = {
         ["not"] = {
            event = "lsp",
            kind = "progress",
         },
         cond = function()
            return not focused
         end,
      },
      view = "notify_send",
      opts = { stop = false, },
   })
end

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
      "folke/noice.nvim",
      enabled = vim.cfg.noice.enabled,
      event = "VeryLazy",
      dependencies = {
         "MunifTanjim/nui.nvim",
         "rcarriga/nvim-notify",
      },
      opts = {
         cmdline = { view = "cmdline_popup", },
         commands = {
            history = {
               view = "popupmenu",
            },
         },
         lsp = {
            override = {
               ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
               ["vim.lsp.util.stylize_markdown"] = true,
               ["cmp.entry.get_documentation"] = true,
            },
         },
         popupmenu = { backend = "cmp", },
         presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = false,      -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
         },
         views = {
            cmdline_popup = {
               position = {
                  row = 5,
                  col = "50%",
               },
               size = {
                  width = 60,
                  height = "auto",
               },
            },
            popupmenu = {
               relative = "editor",
               position = {
                  row = 8,
                  col = "50%",
               },
               size = {
                  width = 60,
                  height = 10,
               },
               border = {
                  style = "rounded",
                  padding = { 0, 1, },
               },
               win_options = {
                  winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo", },
               },
            },
         },
      },
      config = noice_config,
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
      "folke/trouble.nvim",
      dependencies = {
         "nvim-tree/nvim-web-devicons",
      },
      enabled = false,
      cmd = { "TroubleToggle", "Trouble", },
      opts = { use_diagnostic_signs = true, },
      keys = {
         {
            "[q",
            function()
               if require("trouble").is_open() then
                  require("trouble").previous({
                     skip_groups = true,
                     jump = true,
                  })
               else
                  local ok, err = pcall(vim.cmd.cprev)
                  if not ok then
                     vim.notify(err, vim.log.levels.ERROR)
                  end
               end
            end,
            desc = "Previous trouble/quickfix item",
         },
         {
            "]q",
            function()
               if require("trouble").is_open() then
                  require("trouble").next({
                     skip_groups = true,
                     jump = true,
                  })
               else
                  local ok, err = pcall(vim.cmd.cnext)
                  if not ok then
                     vim.notify(err, vim.log.levels.ERROR)
                  end
               end
            end,
            desc = "Next trouble/quickfix item",
         },
      },
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
