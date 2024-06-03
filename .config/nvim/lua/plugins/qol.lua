return
{
   { "dbeniamine/cheat.sh-vim", cmd = "Cheat", },
   {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("better_escape").setup(
            {
               mapping = { "kj", },
               timeout = vim.o.timeoutlen,
               clear_empty_lines = false,
               keys = "<Esc>",
            })
      end,
   },
   {
      "monaqa/dial.nvim",
      -- keys = {
      --    "<leader>i",
      -- },
      -- opts = {
      --    remove_default_keybinds = true,
      -- },
      event = "VeryLazy",
      config = function()
         local manipulate = require("dial.map").manipulate
         vim.keymap.set("n", "<C-a>", function()
            manipulate("increment", "normal")
         end)
         vim.keymap.set("n", "<C-x>", function()
            manipulate("decrement", "normal")
         end)
         vim.keymap.set("n", "g<C-a>", function()
            manipulate("increment", "gnormal")
         end)
         vim.keymap.set("n", "g<C-x>", function()
            manipulate("decrement", "gnormal")
         end)
         vim.keymap.set("v", "<C-a>", function()
            manipulate("increment", "visual")
         end)
         vim.keymap.set("v", "<C-x>", function()
            manipulate("decrement", "visual")
         end)
         vim.keymap.set("v", "g<C-a>", function()
            manipulate("increment", "gvisual")
         end)
         vim.keymap.set("v", "g<C-x>", function()
            manipulate("decrement", "gvisual")
         end)

         local augend = require("dial.augend")

         -- local bool_augend = augend.constant.alias.bool
         -- bool_augend.config.preserve_case = true

         local default_augend =
         {
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.date.alias ["%Y/%m/%d"],
            augend.date.alias ["%Y-%m-%d"],
            augend.date.alias ["%m/%d"],
            augend.date.alias ["%H:%M"],
            -- bool_augend,
         }

         local new_augends = {
            { "and",   "or", }, { "&", "|", }, { "&&", "||", }, { "always", "never", },
            { "false", "true", },
         }

         for _, pair in ipairs(new_augends) do
            table.insert(default_augend,
               augend.constant.new
               {
                  elements = pair,
                  preserve_case = true,
                  word = true,
                  cyclic = true,
               }
            )
         end

         require("dial.config").augends:register_group { default = default_augend, }
      end,
   },

   {
      "lambdalisue/suda.vim",
      event = "VeryLazy",
      config = function()
         vim.g.suda_smart_edit = true
      end,
   },
   -- {
   --   "ggandor/leap.nvim",
   --   config = function()
   --     require('leap').create_default_mappings()
   --   end
   -- },
   {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = true,
   },
   {
      "windwp/nvim-autopairs",
      dependencies =
      {
         "hrsh7th/nvim-cmp",
      },
      event = "InsertEnter",
      opts =
      {
         enable_check_bracket_line = true,
      },
   },
}
