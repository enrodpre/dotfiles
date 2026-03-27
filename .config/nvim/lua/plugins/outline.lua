return {
  "stevearc/aerial.nvim",
  keys = {
    {
      "<leader>oo",
      Lua.lazy.req("aerial").fzf_lua_picker,
      "[O]pen [O]utline",
    },
  },
  opts = {
    layout = {
      min_width = 40,
      max_width = { 70, 0.2 },
    },
    on_attach = function(bufnr)
      local wk = require("which-key")
      wk.add({ "{", "<cmd>AerialPrev<CR>", { buffer = bufnr } })
      wk.add({ "}", "<cmd>AerialNext<CR>", { buffer = bufnr } })
    end,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
}
