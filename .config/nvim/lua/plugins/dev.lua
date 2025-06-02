return {
  "folke/snacks.nvim",
  enabled = false,
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        local Snacks = require("snacks")
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function(...) Snacks.debug.backtrace() end
        -- vim.print = _G.dd
      end,
    })
  end,
}
