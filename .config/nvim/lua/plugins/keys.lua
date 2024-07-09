#!/usr/bin/lua

return {
   "folke/which-key.nvim",
   opts = {
      operators = {
         ["<leader>c"] = "Comments",
      },
      triggers_blacklist = { n = { "o", }, },
   },
   config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.register({
         ["<leader>"] = { casa = "VISUAL <leader>", },
         ["<leader>h"] = { "Git [H]unk", },
      }, { mode = "v", })

      local keys = require("keys")
      local on_start = keys.general
      wk.register(on_start)

      local unmap = keys.unmap

      for mode, keymaps in pairs(unmap) do
         local keyunmap = {}
         for _, lhs in ipairs(keymaps) do
            keyunmap [lhs] = "which_key_ignore"
         end

         wk.register(keyunmap, {
            mode = mode,
            noremap = false,
         })
      end
   end,
}
