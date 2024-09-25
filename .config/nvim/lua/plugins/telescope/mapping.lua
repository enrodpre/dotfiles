#!/usr/bin/lua

local tb = vim.lua.lazyreq.on_exported_call("telescope.builtin")
local nolazy = require("telescope.builtin")

return {
  {
    "<leader>t",
    group = "[T]elescope",
  },
  {
    "<leader>f",
    group = "[F]ind",
  },
  {
    "<leader>fg",
    group = "[G]rep",
  },
  {
    "<S-CR>",
    function()
      require("noice").redirect(vim.fn.getcmdline())
    end,
    desc = "Redirect output of command line",
    mode = "c",
  },
  {
    "<leader>fe",
    tb.buffers,
    desc = "[ ] [F]ind [E]xisting buffers",
  },
  {
    "<leader>fb",
    function()
      tb.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    desc = "[F]uzzily search in current [B]uffer",
  },
  {
    "<leader>ff",
    tb.find_files,
    desc = "[F]ind [F]iles",
  },
  {
    "<leader>fg",
    tb.live_grep,
    desc = "[G]o [G]rep",
  },
  {
    "gh",
    tb.help_tags,
    desc = "[G]o [H]elp",
  },
  {
    "<leader>fgw",
    tb.grep_string,
    desc = "[F]ind by [G]rep current [W]ord",
  },
  {
    "<leader>gf",
    tb.git_files,
    desc = "[G]it [F]iles",
  },
  {
    "<leader>fgg",
    "<cmd>LiveGrepGitRoot<cr>",
    desc = "[F]ind by [G]rep on [G]it root",
  },
  {
    "<leader>tb",
    tb.builtin,
    desc = "[T]elescope [B]uiltins",
  },
  {
    "<leader>tk",
    function()
      nolazy.keymaps()
    end,
    desc = "[T]elescope [K]eymaps",
  },
  {
    "<leader>tr",
    tb.resume,
    desc = "[T]elescope [R]esume",
  },
}
