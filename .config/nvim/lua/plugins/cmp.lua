#!/usr/bin/lua

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "ray-x/cmp-treesitter",
      "chrisgrieser/cmp-nerdfont",
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    event = "InsertEnter",
    config = function(_, opts)
      local cmp = require("cmp")
      local auto_select = false

      local mapping = {
        ["<C-n>"] = cmp.mapping(function()
          if not cmp.visible() then
            cmp.complete()
          else
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
        end, { "i", "c" }),
        ["<C-p>"] = cmp.mapping(function()
          if not cmp.visible() then
            cmp.complete()
          else
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          end
        end, { "i", "c" }),
        ["<C-b>"] = cmp.mapping(function()
          cmp.scroll_docs(-4)
        end, { "i", "c" }),
        ["<C-f>"] = cmp.mapping(function()
          cmp.scroll_docs(4)
        end, { "i", "c" }),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<C-CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<C-y>"] = cmp.mapping(function()
          cmp.confirm({ select = true })
        end, { "i", "c" }),
        ["<C-e>"] = cmp.mapping(function()
          cmp.abort()
        end, { "i", "c" }),
        ["<Tab>"] = cmp.mapping(function(failback)
          return failback
        end, { "c" }),
      }

      local cmp_opts = {
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        formatting = {
          format = function(entry, item)
            local icon = require("mini.icons").get("lsp", item.kind)
            if entry.source.name == "cmdline" then
              item.kind = "󰘳 Cmdline"
            elseif icon then
              item.kind = icon .. " " .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        mapping = mapping,
        preselect = true,
        sources = cmp.config.sources({
          { name = "snippets" },
          { name = "lazydev" },
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
        }),
        -- view = {
        --   entries = {
        --     selection_order = 'near_cursor',
        --     follow_cursor = true,
        --   },
        -- },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }

      opts = vim.tbl_deep_extend("force", cmp_opts, opts)
      cmp.setup(opts)

      -- `/` cmdline setup.
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = cmp.config.sources({
          { name = "path" },
          { name = "dotenv" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
