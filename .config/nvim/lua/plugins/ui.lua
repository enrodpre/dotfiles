local configs = require("configs.ui")

return {
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    "fladson/vim-kitty",
    ft = 'kitty'
  },
  {
    "rebelot/kanagawa.nvim",
    event = "UiEnter",
    opts = {
      compile = true,
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("configs.ui").icons
      local fg = require("utils").fg
      return {
        options = {
          theme = "pywal-nvim",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        -- extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  {
    "mboughaba/i3config.vim",
    ft = 'i3config'
  },
  { "dbeniamine/cheat.sh-vim" },
  {
    "AlphaTechnolog/pywal.nvim",
    event = 'UiEnter',
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      mini = {
        -- timeout = false,
      },
      messages = {
        -- view = "popup"
      }
    },
  },
  {
    "rktjmp/lush.nvim",
    cmd = "LushRunTutorial",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 800
    end,
    opts = {
      -- your configuration comes here
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for keymaps that start with a native binding
        -- i = { "<leader>w" },
        -- n = { "<leader>w" },
      },
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true

      require("utils").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("configs.ui").icons.kinds,
    },
  },
}
