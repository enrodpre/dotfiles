#!/usr/bin/lua

return {
  { "nvim-treesitter/playground", enabled = false },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
    },
    event = { "LazyFile", "VeryLazy" },
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      -- require("nvim-treesitter.query_predicates")
    end,
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "python",
        "rasi",
        "vimdoc",
        "bash",
        "regex",
        "rst",
        "toml",
        "cmake",
        "git_config",
        "gitcommit",
        "git_rebase",
        "gitignore",
        "gitattributes",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = false },
      endwise = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
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
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>p"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>P"] = "@parameter.inner",
          },
        },
      },
    },
  },
}
