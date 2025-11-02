return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    opts = {
      completion = {
        documentation = { auto_show = true },
        keyword = { range = "prefix", },
        list = {
          selection = { preselect = true, auto_insert = true },
          cycle = {
            from_bottom = true,
            from_top = true,
          }
        },
        trigger = {
          show_on_insert = false,
        },
      },
      cmdline = {
        keymap = {
          -- recommended, as the default keymap will only show and select the next item
          ['<C-n>'] = { 'show', "select_next", },
          ['<C-p>'] = { 'show', "select_prev" },
        },
        completion = {
          menu = {
            auto_show = function(_)
              return vim.fn.getcmdtype() == ':'
            end,
          },
        }
      },
      keymap = {
        ['<C-n>'] = {
          "show", "select_next", 'fallback_to_mappings'
        },
      },
      signature = { enabled = true },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities(), true) })
    end
  }
}
