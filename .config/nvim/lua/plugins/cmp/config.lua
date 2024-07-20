#!/usr/bin/lua

return function()
  local luasnip = require 'luasnip'
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}

  local cmp = require 'cmp'
  local mapping = {
    ['<C-n>'] = cmp.mapping(function()
      if not cmp.visible() then
        cmp.complete()
      else
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      end
    end, { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(function()
      if not cmp.visible() then
        cmp.complete()
      else
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      end
    end, { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(function()
      cmp.scroll_docs(-4)
    end, { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(function()
      cmp.scroll_docs(4)
    end, { 'i', 'c' }),
    ['<CR>'] = cmp.mapping(function(fallback)
      -- if cmp.visible() then
      --    cmp.confirm()
      -- else
      fallback()
      -- end
    end, { 'i', 'c' }),
    ['<C-CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping(function()
      cmp.confirm { select = true }
    end, { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping(function()
      cmp.abort()
    end, { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(function(failback)
      return failback
    end, { 'c' }),
  }

  local default_lspkind = require('plugins.cmp.lspkind').cmp_format()
  local default_formatting = {
    format = default_lspkind,
  }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = mapping,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    view = {
      entries = {
        selection_order = 'near_cursor',
        follow_cursor = true,
      },
    },
    sources = cmp.config.sources {
      { name = 'lazydev' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
    formatting = default_formatting,
  }

  -- `/` cmdline setup.
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    formatting = default_formatting,
    sources = {
      { name = 'buffer' },
    },
  })

  -- `:` cmdline setup.
  cmp.setup.cmdline(':', {
    mapping = mapping,
    formatting = default_formatting,
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'dotenv' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- cmp.event:on("confirm_done",
  --    )
  --    require("nvim-autopairs.completion.cmp").on_confirm_done()
end
