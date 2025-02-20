
  return{
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        dap = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
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
        noice = false,
        notify = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,
      },
    },
  }
