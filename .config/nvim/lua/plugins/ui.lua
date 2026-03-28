return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = require("keymaps"),
      win = {
        no_overlap = false,
        row = 30
      },
      debug = false,
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      notify = { enabled = true },

      notifier = { enabled = true },
    },
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "uga-rosa/ccc.nvim",
    opts = {},
    event = "UiEnter",
    keys = {
      { "<leader>pc", "<cmd>CccPick<cr>", desc = "[P]ick [C]olor" },
    },
  },
  {
    "folke/edgy.nvim",
    init = function()
      -- vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    event = "VeryLazy",
    opts = {
      left = {
        {
          ft = "snacks_terminal",
          size = { height = 0.3, width = 45 },
          wo = {
            wrap = false,
            signcolumn = "no",
          },
          title = "",
          filter = function(_, win)
            return vim.w[win].snacks_win
                and vim.w[win].snacks_win.position ~= "float"
                and vim.w[win].snacks_win.relative == "editor"
                and not vim.w[win].trouble_preview
          end,
        },
      },
      bottom = { "Trouble" },
      exit_when_last = true,
      keys = {
        ["<c-q>"] = false,
      },
    },
  },
  {
    "pogyomo/winresize.nvim",
    enabled = false,
    dependencies = {
      { "pogyomo/submode.nvim" },
    },
    keys = {
      {
        "<c-w>r",
        function()
          require("submode").create("WinResize", {
            mode = "n",
            enter = "<c-w>r",
            leave = { "q", "<esc>" },
            default = function(register)
              local res = require("winresize").resize
              register("h", function()
                res(0, 2, "left")
              end)
              register("j", function()
                res(0, 1, "down")
              end)
              register("k", function()
                res(0, 1, "up")
              end)
              register("l", function()
                res(0, 2, "right")
              end)
            end,
          })
          require("submode").enter("WinResize")
        end,
      },
    },
  },
  {
    "tpope/vim-sleuth",
    event = "UiEnter",
  },
  {
    "nvim-mini/mini.cursorword",
    event = "UiEnter",
    opts = {},
  },
}
