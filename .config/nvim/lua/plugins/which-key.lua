local gdb_breakpoint = function()
  local Path = require("plenary.path")
  local filepath = vim.fn.getenv("PWD") .. "/breakpoints"
  local destination = Path:new(filepath)

  local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
  local line = vim.api.nvim_win_get_cursor(0) [1]
  local gdb_instruction = string.format("b %s:%s", file, line)
  vim.print(gdb_instruction)

  destination:touch(gdb_instruction, "w")
  destination:write(gdb_instruction, "w")
end

local global_mapping = {
  { "<leader>p", group = "[P]rint", },
  {
    "<leader>pp",
    function()
      local node = vim.treesitter.get_node():parent()
      -- vim.print(vim.treesitter.get_node_text(node, 0))
    end,
    desc = "[P]rint",
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
    "<leader>sb",
    gdb_breakpoint,
    desc = "Set breakpoint for gdb",
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
  {
    ",o",
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
    "kj",
    "<Esc>",
    desc = "Better escape",
    hidden = true,
    silent = true,
    mode = { "i", },
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
  {
    "<leader>at",
    "<Plug>PlenaryTestFile",
    desc = "[A]pply [T]est current file",
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
      desc = "[O]pen [L]azy",
    },
    {
      "<leader>om",
      "<cmd>messages<cr>",
      desc = "[O]pen [M]essages",
    },
  },
}

return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = global_mapping,
    notify = true,
    triggers = {
      { "<auto>", mode = "nixsotc", },
      { "s",      mode = "n", },
    },
    debug = false,
  },
}
