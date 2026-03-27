local cmdline = {
  keymap = {
    -- recommended, as the default keymap will only show and select the next item
    ["<C-n>"] = { "show", "select_next" },
    ["<C-p>"] = { "show", "select_prev" },
    ["<C-y>"] = { "accept", },
  },
  sources = function()
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype == ":" then
      local line = vim.fn.getcmdline()
      local is = vim.startswith(line, '=')
      vim.print(is)
      if line:match("^lua.*") or is then
        return { "lazydev", }
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
  completion = {
    -- ghost_text = { enabled = true },
    menu = {
      auto_show = true
    },
  }
}

local opts = {
  snippets   = {
    expand = function(snippet, _)
      -- return LazyVim.cmp.expand(snippet)
    end,
  },
  completion = {
    documentation = { auto_show = true },
    keyword = { range = "prefix" },
    ghost_text = {
      enabled = true,
      show_with_menu = true
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
        columns = {
          {
            "label",
            "label_description",
            gap = 1
          }, {
          "source_name",
          "kind"
        }
        },
      },
      auto_show = true
    },
    list = {
      selection = { preselect = false, auto_insert = true },
      cycle = {
        from_bottom = true,
        from_top = true,
      },
    },
    trigger = {
      show_on_insert = true,
    },
  },
  sources    = {
    default = { "lsp", "path", "snippets" },
    per_filetype = {
      lua = {
        inherit_defaults = true,
        "lazydev",
      }
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    }
  },
  keymap     = {
    ["<C-n>"] = {
      "show",
      "select_next",
      "fallback_to_mappings",
    },
    ["<C-p>"] = { "show", "select_prev", "fallback_to_mappings", },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
  },
  signature  = { enabled = true },
  fuzzy      = {
    implementation = "rust",
    -- prebuilt_binaries = { force_version = nil },
  },
  cmdline    = cmdline
}
return {
  {
    "saghen/blink.cmp",
    -- build = 'cargo build --release',
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = opts,
  },
}
