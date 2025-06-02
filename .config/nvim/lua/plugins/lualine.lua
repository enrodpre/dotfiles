local colored_filename = function()
  local disabled = true
  local filename = require("lualine.components.filename")
  if disabled then
    return filename
  end

  local ret = filename:extend()
  local highlight = require("lualine.highlight")
  local colorscheme = require("catppuccin.palettes").get_palette("mocha")

  local default_status_colors = { saved = colorscheme.base, modified = colorscheme.peach }
  local modifications = {
    symbols = {
      readonly = "[X]",
    },
  }

  function ret:init(options)
    options = vim.tbl_deep_extend("force", modifications, options)
    ret.super.init(self, options)
    self.status_colors = {
      saved = highlight.create_component_highlight_group(
        { bg = default_status_colors.saved },
        "filename_status_saved",
        self.options
      ),
      modified = highlight.create_component_highlight_group(
        { bg = default_status_colors.modified },
        "filename_status_modified",
        self.options
      ),
    }
    if self.options.color == nil then
      self.options.color = ""
    end
  end

  function ret:update_status()
    local data = ret.super.update_status(self)
    data = highlight.component_format_highlight(
      vim.bo.modified and self.status_colors.modified or self.status_colors.saved
    ) .. data
    return data
  end

  return ret
end

local trouble_status = function()
  local trouble = require("trouble")
  local symbols = trouble.statusline
      and trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
  return symbols
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "UiEnter",
  -- init = function()
  --   vim.g.lualine_laststatus = vim.o.laststatus
  --   if vim.fn.argc(-1) > 0 then
  --     -- set an empty statusline till lualine loads
  --     vim.o.statusline = " "
  --   else
  --     -- hide the statusline on the starter page
  --     vim.o.laststatus = 0
  --   end
  -- end,
  opts = function()
    local opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        globalstatus = vim.o.laststatus == 3,
        component_separators = "|",
        -- section_separators = "",
      },
      extensions = { "lazy", "quickfix" },
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
        lualine_b = { colored_filename() },
        lualine_c = {
          "diagnostics", {},
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
