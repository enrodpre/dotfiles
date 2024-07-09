#!/usr/bin/lua

local source_mapping = {
   buffer = "[Buffer]",
   nvim_lsp = "[LSP]",
   luasnip = "[LuaSnip]",
   nvim_lua = "[Lua]",
   latex_symbols = "[Latex]",
   path = "[Path]",
   treesitter = "[Tree]",
}

local default = {
   mode = "symbol_text",
   show_labelDetails = true,
   menu = source_mapping,
   ellipsis_char = "...",
   before = function(entry, item)
      require("tailwindcss-colorizer-cmp").formatter(entry,
         item)

      if entry.source.name == "cmdline" then
         item.kind = "󰘳 Cmdline"
      end

      return item
   end,
}

return {
   cmp_format = function(opts)
      opts = opts or {}
      opts = vim.tbl_deep_extend("force", default, opts)

      return require("lspkind").cmp_format(opts)
   end,
}
