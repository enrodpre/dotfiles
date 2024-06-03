#!/usr/bin/lua

return {
   -- Highlight, edit, and navigate code
   "nvim-treesitter/nvim-treesitter",
   dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
   },
   lazy = false,
   build = ":TSUpdate",
   config = vim.defer_fn(function()
      require("nvim-treesitter.configs").setup {
         ensure_installed = { "c", "cpp", "go", "lua", "python", "rust",
            "tsx", "javascript", "typescript", "vimdoc", "vim", "bash", "regex", "ninja", "rst", "toml", },

         -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
         auto_install = true,

         highlight = { enable = true, },
         indent = { enable = true, },
         endwise = { enable = true, },
         textobjects = {
            select = {
               enable = true,
               lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
      }
   end, 0),


}
