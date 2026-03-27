vim.api.nvim_create_autocmd("User", {
  desc = "Disable some defalt mapping",
  pattern = "LazyLoad",
  callback = function()
    local delete = {
      gc = { "x", "n" },
      gcc = { "n" },
    }

    for lhs, modes in pairs(delete) do
      --- @type table
      for _, mode in ipairs(modes) do
        vim.api.nvim_del_keymap(mode, lhs)
      end
    end
  end,
  once = true,
})


return {
  { "<MiddleMouse>",   "<Nop>",         mode = { "n", "i" }, },
  { "<2-MiddleMouse>", "<Nop>",         mode = { "n", "i" }, },
  { "<3-MiddleMouse>", "<Nop>",         mode = { "n", "i" }, },
  { "<4-MiddleMouse>", "<Nop>",         mode = { "n", "i" }, },
  { "<leader>p",       group = "[P]ick" },
  {
    ",r",
    function()
      vim.cmd("luafile %")
      vim.print(string.format("Reloaded %s file.", vim.fn.expand("%")))
    end,
    desc = "[R]eload current file",
  },
  {
    ",p",
    Lua.get_lsp_diagnostic_information,
    desc = "Print more info about diagnostic",
  },
  {
    "<c-[",
    proxy = "<c-o>",
    desc = "Go back (<C-O>)",
    mode = "n",
  },
  { "<", "<gv", mode = "v" },
  { ">", ">gv", mode = "v" },
  {
    ",o",
    "a<CR><Esc>",
    desc = "Put next line in next character",
  },
  {
    {
      "<C-Q>",
      "<cmd>q<cr>",
      desc = "Quit neovim",
    },
    {
      "<C-Q><C-Q>",
      "<cmd>q!<cr>",
      desc = "Force quit",
    },
  },
  {
    "<C-s>",
    "<cmd>w<CR>",
    desc = "Save",
  },
  {
    "<C-s><C-a>",
    "<cmd>wa<CR>",
    desc = "Save all buffers",
  },
  {
    "g",
    group = "[G]o",
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
    "<Esc>",
    "<Esc>:let @/ = ''<CR>",
    desc = "Escape will clear search pattern",
    silent = true,
  },
  {
    "<leader>d",
    group = "[D]ap",
  },
  {
    "<leader>ol",
    function()
      require("lazy").show()
    end,
    desc = "[O]pen [L]azy",
  },
  {
    "<leader>ar",
    function()
      require("library.pickers").completions("Lazy reload")
    end,
    desc = "[A]pply [R]eload",
  },
  {
    "<leader>om",
    "<cmd>messages<cr>",
    desc = "[O]pen [M]essages",
  },
  {
    {
      "<C-w>",
      [[<C-\><C-n><C-w>]],
      mode = "t",
    },
  },
  { ",t", function() Lua.run_test() end }
}
