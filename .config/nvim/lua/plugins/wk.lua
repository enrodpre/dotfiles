#!/usr/bin/lua

local global_mapping = {
  {
    "<c-]",
    proxy = "<c-o>",
    desc = "Go back (<C-O>)",
  },
  {
    "<leader>a",
    group = "[A]pply",
  },
  {
    "<C-o>",
    "a<CR><Esc>",
    desc = "Put next line in next character",
  },
  {
    "<leader>d",
    group = "[D]ap",
  },
  {
    "<leader>ar",
    function()
      vim.print(vim.lua.fn.editor)
    end,
    desc = "[A]pply [R]eload",
  },
  {
    "<C-Q>",
    ":q <CR>",
    desc = "Quit neovim",
    noremap = false,
  },
  {
    "<leader>s",
    group = "[S]et",
  },
  {
    "<leader>c",
    group = "[C]omment",
  },
  {
    "<C-Q><C-Q>",
    ":q! <CR>",
    desc = "Force quit",
  },
  {
    "<C-s>",
    "<cmd>w<CR>",
    desc = "Save",
  },
  { "kj", "<Esc>", desc = "Better escape", mode = { "i", "c" } },
  {
    "g",
    group = "[G]o",
  },
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
    "<leader>l",
    group = "[L]azy",
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
    "<Esc>",
    "<Esc>:let @/ = ''<CR>",
    desc = "Escape will clear search pattern",
    silent = true,
  },
  { "<leader>e", group = "[E]xecute" },
  {
    "<leader>at",
    "<Plug>PlenaryTestFile",
    desc = "[A]pply [T]est current file",
  },
  {
    "<leader>om",
    "<cmd>messages<cr>",
    desc = "[O]pen [M]essages",
  },
  {
    "<leader>o",
    group = "[O]pen",
  },
  {
    "<leader>ol",
    function()
      require("lazy").show()
    end,
    desc = "[O]pen [L]azy",
  },
  {
    "<leader>u",
    group = "[U]i",
  },
  {
    "<leader>ob",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
}

return {
  "folke/which-key.nvim",
  dependencies = {
    { "echasnovski/mini.icons" },
  },
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = global_mapping,
    notify = true,
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "s", mode = "n" },
    },
    debug = false,
  },
}
