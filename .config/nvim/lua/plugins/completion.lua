return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    -- version = "1.*",
    opts = {
      completion = {
        documentation = { auto_show = true },
        keyword = { range = "prefix" },
        list = {
          selection = { preselect = true, auto_insert = true },
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },
        trigger = {
          show_on_insert = true,
        },
      },
      cmdline = {
        keymap = {
          -- recommended, as the default keymap will only show and select the next item
          ["<C-n>"] = { "show", "select_next" },
          ["<C-p>"] = { "show", "select_prev" },
        },
        completion = {
          menu = {
            auto_show = function(_)
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets" },
      },
      keymap = {
        ["<C-n>"] = {
          "show",
          "select_next",
          "fallback_to_mappings",
        },
      },
      signature = { enabled = true },
      fuzzy = {
        implementation = "prefer_rust",
        prebuilt_binaries = { force_version = "1.9.1" },
      },
    },
  },
}
