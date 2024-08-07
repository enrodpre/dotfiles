local dial_map = vim.lua.lazyreq.on_exported_call("dial.map")

local dial_keys = function()
  local keys = {}

  local manipulate = dial_map.manipulate
  local data = {
    { "n", "<C-a>", "increment", "normal", "Increment <cword>" },
    { "n", "<C-x>", "decrement", "normal", "Decrement <cword>" },
    { "n", "g<C-a>", "increment", "gnormal", "Additive increment <cword>" },
    { "n", "g<C-x>", "decrement", "gnormal", "Additive decrement <cword>" },
    { "v", "<C-a>", "increment", "visual", "Increment <cword>" },
    { "v", "<C-x>", "decrement", "visual", "Decrement <cword>" },
    { "v", "g<C-a>", "increment", "gvisual", "Additive increment <cword>" },
    { "v", "g<C-x>", "decrement", "gvisual", "Additive decrement <cword>" },
  }

  for _, row in ipairs(data) do
    local mode, lhs, dir, rhs, desc = unpack(row)
    local key = {
      lhs,
      function()
        manipulate(dir, rhs)
      end,
      desc = desc,
      mode = mode,
    }

    table.insert(keys, key)
  end

  return keys
end

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
  {
    "echasnovski/mini.pairs",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      modes = { command = true, insert = true },
      mappings = {
        ["<"] = {
          action = "open",
          pair = "<>",
          neigh_pattern = "\r.",
          register = { cr = false },
        },
      },
    },
  },
  {
    "tpope/vim-sleuth",
    event = "LazyFile",
  },
  {
    "monaqa/dial.nvim",
    keys = dial_keys(),
    config = function()
      local augend = require("dial.augend")

      local default_augend = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
      }

      local create_autogends = function(list, word)
        word = word or true
        for _, pair in ipairs(list) do
          table.insert(
            default_augend,
            augend.constant.new({
              elements = pair,
              preserve_case = true,
              word = true,
              cyclic = true,
            })
          )
        end
      end

      local new_augends = {
        {
          { "and", "or" },
          { "always", "never" },
          { "false", "true" },
          { "False", "True" },
          { "horizontal", "vertical" },
          { "yes", "no" },
        },
        {
          { "&", "|" },
          { "&&", "||" },
          { "+", "-" },
          { "==", "!=" },
        },
      }

      local words, tokens = unpack(new_augends)
      create_autogends(words)
      create_autogends(tokens, false)

      require("dial.config").augends:register_group({ default = default_augend })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    keys = {
      {
        "<C-u>",
        function()
          require("neoscroll").ctrl_u({ duration = 250, easing = "sine" })
        end,
      },
      {
        "<C-d>",
        function()
          require("neoscroll").ctrl_d({ duration = 250, easing = "sine" })
        end,
      },
      -- Use the "circular" easing functio
      {
        "<C-b>",
        function()
          require("neoscroll").ctrl_b({ duration = 250, easing = "circular" })
        end,
      },
      {
        "<C-f>",
        function()
          require("neoscroll").ctrl_f({ duration = 250, easing = "circular" })
        end,
      },
      -- When no value is passed the `easing` option supplied in `setup()` is used
      {
        "<C-y>",
        function()
          require("neoscroll").scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
      },
      {
        "<C-e>",
        function()
          require("neoscroll").scroll(0.1, { move_cursor = false, duration = 100 })
        end,
      },
    },

    config = function()
      require("neoscroll").setup({ easing = "quadratic" })
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "LazyFile",
    opts = {},
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",

          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "LazyFile",
    opts = {},
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.grug_far({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
