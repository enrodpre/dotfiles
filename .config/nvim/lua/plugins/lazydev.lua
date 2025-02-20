return {
  "folke/lazydev.nvim",
  dependencies = {
    "Bilal2453/luvit-meta",
    "neovim/nvim-lspconfig"
  },
  ft = "lua",
  opts = function(_, opts)
    opts.library = opts.library or {}
    table.insert(opts.library, {
      "lazy.nvim",
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      "neodev.nvim/types/stable",
    })
    return opts
  end,
}
