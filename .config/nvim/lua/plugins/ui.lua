vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights when yanking",
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 250 })
  end,
})

return {
  -- { "ziontee113/color-picker.nvim", opts = {}, event = "UiEnter" },
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
    "nvim-mini/mini.hipatterns",
    version = false,
    event = "UiEnter",
    opts = function()
      local hi = require("mini.hipatterns")
      local ret = {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
      return ret
    end,
  },
  {
    "nvim-mini/mini.cursorword",
    event = "UiEnter",
    opts = {},
  },
}
