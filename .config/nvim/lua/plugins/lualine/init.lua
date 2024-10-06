local components = require("plugins.lualine.components")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "UiEnter",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        globalstatus = vim.o.laststatus == 3,
        component_separators = "|",
        -- section_separators = "",
      },
      extensions = { "mason", "lazy", "quickfix" },
      sections = {
        lualine_a = {
          "mode",
          {
            function()
              return "Recording Macro"
            end,
            cond = function()
              return vim.fn.reg_recording() ~= ""
            end,
          },
        },
        lualine_b = { components.colored_filename() },
        lualine_c = {
          "diagnostics",
        },
        lualine_x = {
          "encoding",
          "filetype",
        },
        lualine_y = {
          "searchcount",
          "selectioncount",
        },
        lualine_z = {
          {
            "location",
            fmt = function(str)
              local template = "%s  | %s"
              return template:format(str, vim.fn.line("$"))
            end,
          },
        },
      },
    }

    return opts
  end,
}
