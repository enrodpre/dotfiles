return {

  { "<leader>p", group = "[P]rint", },
  {
    ",r",
    function()
      vim.cmd("luafile %")
      vim.print(string.format("Reloaded %s file.", vim.fn.expand("%")))
    end,
    desc = "[R]eload current file",
  },
  {
    "<leader>pa",
    function()
      local node = vim.treesitter.cpp.get_template_parameter_node { index = 1, }
      vim.print(vim.treesitter.get_node_text(node, 0))
    end,
    desc = "[P]rint Template [A]rgument",
  },
  {
    "<leader>pt",
    function()
      local node = vim.treesitter.cpp.get_full_type_node()
      vim.print(vim.treesitter.get_node_text(node, 0))
    end,
    desc = "[P]rint Full [T]ype",
  },
  {
    ",p",
    function()
      Lua.get_lsp_diagnostic_information()
    end,
    desc = "Print more info about diagnostic",
  },
  {
    "gw",
    "<c-w>w",
    desc = "Switch windows",
  },
  {
    "<c-[",
    proxy = "<c-o>",
    desc = "Go back (<C-O>)",
  },
  {
    "<leader>a",
    group = "[A]pply",
  },
  { "<",         "<gv",             mode = "v", },
  { ">",         ">gv",             mode = "v", },
  {
    ",o",
    "a<CR><Esc>",
    desc = "Put next line in next character",
  },
  {
    {
      "<C-Q>",
      ":q <CR>",
      desc = "Quit neovim",
      noremap = false,
    },
    {
      "<C-Q><C-Q>",
      ":q! <CR>",
      desc = "Force quit",
    },
  },
  {
    "<leader>s",
    group = "[S]et",
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
  { "<leader>e", group = "[E]xecute", },
  -- { "<Esc>",     "<C-c>",             desc = "Better escape", },
  {
    "<leader>at",
    "<Plug>PlenaryTestFile",
    desc = "[A]pply [T]est current file",
  },
  {
    "<leader>d",
    group = "[D]ap",
  },
  {
    {
      "<leader>o",
      group = "[O]pen",
    },
    {
      "<leader>op",
      function()
        require("lazy").show()
      end,
      desc = "[O]pen Lazy",
    },
    {
      "<leader>om",
      "<cmd>messages<cr>",
      desc = "[O]pen [M]essages",
    },
  },
  {
    {
      "<D-h>", [[<Cmd>wincmd h<CR>]], mode = "nt",
    },
    {
      "<D-j>", [[<Cmd>wincmd j<CR>]], mode = "nt",
    },
    {
      "<D-k>", [[<Cmd>wincmd k<CR>]], mode = "nt",
    },
    {
      "<D-l>", [[<Cmd>wincmd l<CR>]], mode = "nt",
    },
    {
      "<C-w>", [[<C-\><C-n><C-w>]], mode = "t",
    },

  },
}
