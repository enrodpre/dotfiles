#!/usr/bin/lua

return {
  "catppuccin/nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,
  name = "catppuccin",
  config = function(_, opts)
    require("catppuccin").setup(opts)
  end,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      cmp = true,
      dap = true,
      dap_ui = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "mocha", -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = true,
      },
      mason = true,
      markdown = true,
      mini = {
        enabled = true,
        indentscope_color = "mocha",
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
      neogit = false,
      neotest = true,
      noice = true,
      notify = true,
      nvimtree = false,
      rainbow_delimiters = false,
      telescope = { enabled = true },
      treesitter = true,
      treesitter_context = true,
      lsp_trouble = true,
      ufo = true,
      which_key = true,
    },
  },
}
