#!/usr/bin/lua


return {
   "folke/which-key.nvim",
   opts = {
      operators = {
         ["<leader>c"] = "Comments",
      },
      triggers_blacklist = {
         n = { "o", "oo", },
      },
   },
   config = function(opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.register({
         ["<leader>"] = { casa = "VISUAL <leader>", },
         ["<leader>h"] = { "Git [H]unk", },
      }, { mode = "v", })

      local on_start = require("keys").general
      wk.register(on_start)
   end,
}
