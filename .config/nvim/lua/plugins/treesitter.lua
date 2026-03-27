local modules = {
  select = {
    keymaps = {
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner",
      ["a/"] = "@comment.outer",
    },
    selection_modes = {
      ['@parameter.outer'] = 'v',
      ['@function.outer'] = 'V',
      ['@class.outer'] = '<c-v>',
    },
  },
  move = {
    goto_next_start = {
      ["]f"] = "@function.outer",
      ["]c"] = "@class.outer",
      ["]p"] = "@parameter.inner",
      ["]b"] = "@block.outer",
      ["]l"] = "@loop.outer",
      ["]i"] = "@conditional.outer",
      ["]m"] = "@call.outer",
      ["]a"] = "@assignment.outer",
      ["]o"] = "@loop.*", -- Pattern match
      ["]s"] = { query = "@local.scope", query_group = "locals" },
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
    goto_next = {
      ["]d"] = "@conditional.outer",
    },
    goto_previous = {
      ["[d"] = "@conditional.outer",
    }
  },
  swap = {
    swap_next = {
      [",a"] = "@parameter.inner",
      [",sf"] = "@function.outer",
      [",sa"] = "@assignment.outer",
    },
    swap_previous = {
      [",A"] = "@parameter.inner",
      [",sF"] = "@function.outer",
      [",sA"] = "@assignment.outer",
    },
  },
}
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
      { "RRethy/nvim-treesitter-endwise" },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
      },
    },
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable: missing-fields
      require("nvim-treesitter.configs").setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        }, }
      ---@diagnostic enable: missing-fields

      for k, action in pairs(modules.select.keymaps) do
        vim.keymap.set({ "x", "o" }, k, function()
          require "nvim-treesitter-textobjects.select".select_textobject(action, "textobjects")
        end)
      end
      for motion, keymaps in pairs(modules.swap) do
        for k, action in pairs(keymaps) do
          vim.keymap.set("n", k, function()
            require("nvim-treesitter-textobjects.swap")[motion](action)
          end)
        end
      end

      for motion, keymaps in pairs(modules.move) do
        for k, action in pairs(keymaps) do
          vim.keymap.set("n", k, function()
            require("nvim-treesitter-textobjects.move")[motion](action)
          end)
        end
      end
    end
  },
}
