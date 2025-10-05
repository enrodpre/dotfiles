return {
  {
    "zaldih/themery.nvim",
    cmd = "Themery",
    lazy = false,
    opts = function()
      local available_colorschemes = vim.fn.getcompletion("", "color")
      local colorschemes = {}
      for _, colorscheme in ipairs(available_colorschemes) do
        table.insert(colorschemes, colorscheme)
      end

      return {
        themes = colorschemes,
        livePreview = true, -- Apply theme while picking. Default to true.
      }
    end
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        aerial = true,
        dap = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        markdown = true,
        mini = {
          enabled = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotest = true,
        noice = require("plugins/noice").enabled,
        nvim_surround = false,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  }
}
