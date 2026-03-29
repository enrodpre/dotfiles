local next_on_ghost = function(cmp)
  cmp.select_next { on_ghost_text = true }
end


return {
  {
    "saghen/blink.cmp",
    build = 'cargo build --release',
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        opts = {},
        version = "*",
      },
      "bydlw98/blink-cmp-env",
    },
    -- opts_extend = {
    --   "sources.completion.enabled_providers",
    --   "sources.compat",
    --   "sources.default",
    -- },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      completion = {
        documentation = { window = { border = 'single' }, auto_show = true },
        keyword = { range = "prefix" },
        ghost_text = {
          enabled = true,
          show_with_menu = true
        },
        menu = {
          border = "single",
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
            treesitter = { "lsp" },
          },
          auto_show = true
        },
        list = {
          selection = { preselect = false, auto_insert = true },
          cycle = { from_bottom = true, from_top = true, },
        },
        trigger = { show_on_insert = true, },
      },
      sources    = {
        default = { "lsp", "path", "snippets", "buffer", "env" },
        per_filetype = { lua = { inherit_defaults = true, "lazydev", } },
        providers = {
          env = {
            name = "Env",
            module = "blink-cmp-env",
            opts = {
              -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
              show_braces = false,
              show_documentation_window = true,
            },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        }
      },
      keymap     = {
        ["<C-n>"] = { "show", next_on_ghost, "fallback_to_mappings", },
        ["<C-p>"] = { "show", "select_prev", "fallback_to_mappings", },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
      },
      signature  = { window = { border = 'single' }, enabled = true },
      fuzzy      = { implementation = "rust", },
      cmdline    = {
        completion = { menu = { auto_show = true } },
        keymap = {
          preset = "inherit",
          -- ["<C-n>"] = { "show", next_on_ghost},
          -- ["<C-p>"] = { "show", "select_prev" },
          -- ["<C-y>"] = { "accept", },
        },
        sources = function()
          local cmdtype = vim.fn.getcmdtype()
          if cmdtype == ":" then
            local line = vim.fn.getcmdline()
            if vim.startswith(line, 'lua') or vim.startswith(line, '=') then
              return { "lazydev", "lsp", }
            else
              return { 'cmdline', 'buffer' }
            end
          elseif cmdtype == '/' or cmdtype == '?' then
            return { 'buffer' }
          else
            return {}
          end
          -- Commands
        end,
      }
    },
  },
  {
    "xzbdmw/colorful-menu.nvim",
    opts = {
      ls = {
        lua_ls = {
          -- Maybe you want to dim arguments a bit.
          arguments_hl = "@comment",
        },
        ts_ls = {
          -- false means do not include any extra info,
          -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
          extra_info_hl = "@comment",
        },
        vtsls = {
          -- false means do not include any extra info,
          -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          -- Such as (as Iterator), (use std::io).
          extra_info_hl = "@comment",
          -- Similar to the same setting of gopls.
          align_type_to_right = true,
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        clangd = {
          -- Such as "From <stdio.h>".
          extra_info_hl = "@comment",
          -- Similar to the same setting of gopls.
          align_type_to_right = true,
          -- the hl group of leading dot of "•std::filesystem::permissions(..)"
          import_dot_hl = "@comment",
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        zls = {
          -- Similar to the same setting of gopls.
          align_type_to_right = true,
        },
        roslyn = {
          extra_info_hl = "@comment",
        },
        dartls = {
          extra_info_hl = "@comment",
        },
        -- The same applies to pyright/pylance
        basedpyright = {
          -- It is usually import path such as "os"
          extra_info_hl = "@comment",
        },
        pylsp = {
          extra_info_hl = "@comment",
          -- Dim the function argument area, which is the main
          -- difference with pyright.
          arguments_hl = "@comment",
        },
        -- If true, try to highlight "not supported" languages.
        fallback = true,
        -- this will be applied to label description for unsupport languages
        fallback_extra_info_hl = "@comment",
      },
      -- If the built-in logic fails to find a suitable highlight group for a label,
      -- this highlight is applied to the label.
      fallback_highlight = "@variable",
      -- If provided, the plugin truncates the final displayed text to
      -- this width (measured in display cells). Any highlights that extend
      -- beyond the truncation point are ignored. When set to a float
      -- between 0 and 1, it'll be treated as percentage of the width of
      -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
      -- Default 60.
      max_width = 60,
    },
  }
}
