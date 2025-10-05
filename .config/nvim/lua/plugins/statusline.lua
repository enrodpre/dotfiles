return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons", },
  event = "UiEnter",
  init = function()
    vim.opt.cmdheight = 0
    vim.opt.showmode = false          -- Don't show mode in command line
    vim.opt.ruler = false             -- Don't show cursor position
    vim.opt.showcmd = true
    vim.opt.showcmdloc = "statusline" -- Don't show partial command
  end,
  opts = function()
    local overseer = require "overseer"
    return {
      extensions = {
        "lazy",
        "nvim-dap-ui",
        "quickfix",
        "trouble",
        -- terminal = {
        --   sections = {
        --     lualine_a = {
        --       'mode'
        --     }
        --   },
        --   filetypes = {
        --     'snacks_terminal'
        --   }
        -- }
      },
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "snacks_terminal" } },
        component_separators = "",
        -- section_separators = "",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local submode = require "submode".mode()
              if submode and submode ~= "" then
                return string.upper(submode)
              end
              return str
            end
          },
          {
            function()
              return "Recording @" .. vim.fn.reg_recording()
            end,
            cond = function()
              return vim.fn.reg_recording() ~= ""
            end,
          },
        },
        lualine_b = {
          "filename",
        },
        lualine_c = {
          "diagnostics",
          {
            "overseer",
            label = "",
            colored = true,
            symbols = {
              [overseer.STATUS.FAILURE] = "󰅚 CMake",
              [overseer.STATUS.CANCELED] = " CMake",
              [overseer.STATUS.SUCCESS] = "󰄴 CMake",
              [overseer.STATUS.RUNNING] = "󰑮 CMake",
            },
            unique = true
          },
        },
        lualine_x = {
          "%S",
          "filesize",
          "filetype",
          "lsp_status",
          {
            function() return "venv-selector" end,
            cond = function() return vim.bo.filetype == "python" end
          },
        },
        lualine_y = {
          "searchcount",
          -- {
          --   require("noice").api.status.search.get,
          --   cond = require("noice").api.status.search.has,
          -- },
          "selectioncount",
        },
        lualine_z = {
          'location',
          'progress'
        },
      }
    }
  end
}
