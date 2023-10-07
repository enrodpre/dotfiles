local function opts()
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
  return {
    enabled = function()
      local context = require("cmp.config.context")
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, vim_item)
        local menu_icon = {
          nvim_lsp = "λ",
          luasnip = "⋗",
          buffer = "Ω",
          path = "🖫",
        }
        vim_item.kind = string.format("%s %s", menu_icon[vim_item.kind], vim_item.kind)

        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          buffer = "[BUF]",
        })[entry.source.name]

        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      {
        name = "luasnip",
        option = {
          show_autosnippets = true,
        }
      },
      -- { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
      { name = "git" },
      { name = "kitty" },
      { name = "zsh" },
      { name = 'emoji' },
      { name = 'plugins' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'vim_lsp' },
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },

    mapping =
        cmp.mapping.preset.insert({
          ["<c-k>"]     = cmp.mapping.select_prev_item(),
          ["<c-j>"]     = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<c-e>"]     = cmp.mapping.close(),
          ["<cr>"]      = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.replace,
            select = true,
          }),
          ["<tab>"]     = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(
                vim.api.nvim_replace_termcodes("<plug>luasnip-expand-or-jump", true, true, true),
                ""
              )
            else
              fallback()
            end
          end,
          ["<s-tab>"]   = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end,
        })
    ,
    sorting = defaults.sorting,
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
  }
end

local function config()
  local cmp = require("cmp")
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

  cmp.setup(opts())

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
      },
      {
        { name = 'cmdline' }
      }
    )
  })
end

return
{
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      -- "saadparwaiz1/cmp_luasnip",
      -- "folke/neodev.nvim",
      {
        "KadoBOT/cmp-plugins",
        config = function()
          require("cmp-plugins").setup({})
        end
      },
    },
    event = "InsertEnter",
    version = false,
    config = config,
  },
}
