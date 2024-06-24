#!/usr/bin/lua


local source_mapping = {
   nvim_lsp = "[LSP]",
   nvim_lua = "[LUA]",
   luasnip = "[SNIP]",
   buffer = "[BUF]",
   path = "[PATH]",
   treesitter = "[TREE]",
}

return function()
   local luasnip = require "luasnip"
   require("luasnip.loaders.from_vscode").lazy_load()
   luasnip.config.setup {}

   local cmp = require "cmp"
   local mapping = {
      ["<C-n>"] = cmp.mapping(
         function()
            if not cmp.visible() then
               cmp.complete()
            else
               cmp.select_next_item { behavior = cmp.SelectBehavior.Select, }
            end
         end, { "i", "c", }),
      ["<C-p>"] = cmp.mapping(
         function()
            if not cmp.visible() then
               cmp.complete()
            else
               cmp.select_prev_item { behavior = cmp.SelectBehavior.Select, }
            end
         end, { "i", "c", }),
      ["<C-b>"] = cmp.mapping(function() cmp.scroll_docs(-4) end, { "i", "c", }),
      ["<C-f>"] = cmp.mapping(function() cmp.scroll_docs(4) end, { "i", "c", }),
      ["<CR>"] = cmp.mapping(
         function(fallback)
            -- if cmp.visible() then
            --    cmp.confirm()
            -- else
            fallback()
            -- end
         end,
         { "i", "c", }),
      ["<C-CR>"] = cmp.mapping(
         function(fallback)
            if cmp.visible() then
               cmp.confirm()
            else
               fallback()
            end
         end,
         { "i", "c", }),
      ["<C-y>"] = cmp.mapping(
         function() cmp.confirm() end,
         { "i", "c", }),
      ["<C-e>"] = cmp.mapping(
         function() cmp.abort() end,
         { "i", "c", }),
   }

   cmp.setup {
      snippet = {
         expand = function(args)
            luasnip.lsp_expand(args.body)
         end,
      },
      completion = {
         completeopt = "menu,menuone,noinsert",
      },
      mapping = mapping,
      preselect = cmp.PreselectMode.Item,
      keyword_length = 2,
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
      view = {
         entries = {
            name = "custom",
            selection_order = "near_cursor",
            follow_cursor = true,
         },
      },
      sources = cmp.config.sources({
         { name = "nvim_lsp", },
         { name = "luasnip", },
         { name = "nvim_lua", },
         { name = "lazydev", },
      }, { name = "buffer", }),
      formatting = {
         format = require("lspkind").cmp_format({
            mode = "symbol_text",
            ellipsis_char = "...",
            before = function(entry, vim_item)
               require("tailwindcss-colorizer-cmp").formatter(entry,
                  vim_item)
               return vim_item
            end,
            menu = source_mapping,
         }),
         expandable_indicator = true,
      },
      sorting = {
         priority_weight = 2,
         comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
         },
      },
      experimental = {
         -- native_menu = false,
         ghost_text = false,
      },
   }

   -- `/` cmdline setup.
   cmp.setup.cmdline("/", {
      sources = {
         { name = "buffer", },
      },
   })

   -- `:` cmdline setup.
   cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
         { name = "path", },
      }, {
         { name = "cmdline", },
      }),
   })


   cmp.event:on("confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done())
end
