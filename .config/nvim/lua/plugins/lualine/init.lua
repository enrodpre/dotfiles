return {
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
      extensions = {
         "mason", "lazy", "quickfix",
      },
      sections = {
         lualine_a = { "mode", },
         lualine_b = { "branch", "diff", "diagnostics", },
         lualine_c = { "filename", },
         lualine_x = { "encoding", "filetype", },
         lualine_y = {
            "vim.fn.line('$')",
            {
               require("noice").api.status.search.get,
               cond = require("noice").api.status.search.has,
               -- color = { fg = "#ff9e64", },
            },
         },
         lualine_z = { "location", },
      },
   },
}
