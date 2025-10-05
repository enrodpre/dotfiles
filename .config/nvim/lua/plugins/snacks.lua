return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    debug = {
      enabled = true
    },
    explorer = { enabled = false },
    input = { enabled = true },
    indent = { enabled = true },
    notify = { enabled = true },
    notifier = { enabled = true },
    styles = {
      enabled = true,
      -- terminal = {
      --   position = "left",
      --   height = 0.6,
      --   width = 80
      -- },
    },
    terminal = { enabled = true, },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    _G.dd = Snacks.debug.inspect
    _G.bt = Snacks.debug.backtrace
    vim.print = dd
  end,
  keys = {
    {
      [[<c-\>]],
      function()
        Snacks.terminal.toggle(nil, {
          start_insert = false,
          auto_insert = false,
          auto_close = false
        })
      end,
      mode = { "n", "t" },
      desc = "Toggle Terminal"
    },
  }
}
