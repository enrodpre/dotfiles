#!/usr/bin/lua

local lazy_load_extension = vim.lua.fn.lazy_load_extension

M = {}

M.specs = {
  { "debugloop/telescope-undo.nvim", cmd = "Telescope undo" },
  {
    "piersolenski/telescope-import.nvim",
    cmd = "Telescope import",
  },
  { "LinArcX/telescope-scriptnames.nvim", cmd = "Telescope scripts" },
  {
    "tsakirist/telescope-lazy.nvim",
    cmd = "Telescope lazy",
  },
  {
    "polirritmico/telescope-lazy-plugins.nvim",
    cmd = "Telescope plugins",
  },
  { "nvim-telescope/telescope-vimspector.nvim", cmd = "Telescope inspector" },
  {
    "doctorfree/cheatsheet.nvim",
    cmd = "Telescope cheatsheet",
    dependencies = { "nvim-lua/popup.nvim" },
  },
  { "gbrlsnchs/telescope-lsp-handlers.nvim", cmd = "Telescope lsp" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    init = lazy_load_extension("fzf"),
  },
  -- Dependencies
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-lua/plenary.nvim" },
}

M.keymaps = {
  {
    "<leader>rp",
    group = "[R]efactoring [P]rintf",
  },
  {
    "<leader>r",
    group = "[R]efactoring",
  },
  {
    "<leader>ol",
    group = "[O]pen [L]azy",
  },
  {
    "<leader>on",
    function()
      vim.lua.lazyreq.on_module_call("plugins.telescope.pickers").choose_neogen()
    end,
    desc = "[O]pen [N]eogen",
  },
  {
    "<leader>oi",
    function()
      require("telescope").extensions.vimspector.configurations()
    end,
    desc = "[O]pen [I]nspector",
  },
  {
    "<leader>tc",
    "<cmd>Cheatsheet<CR>:",
    desc = "[T]elescope [C]heatsheet",
  },
  {
    "<leader>oll",
    "<cmd>Telescope lazy<CR>",
    desc = "[O]pen [L]azy",
  },
  {
    "<leader>olp",
    ":Telescope lazy_plugins<CR>",
    desc = "[O]pen [L]azy [P]lugins",
  },
  {
    "<leader>rr",
    vim.lsp.buf.rename,
    desc = "[R]ename",
  },
  {
    "<leader>re",
    function()
      require("telescope").extensions.refactoring.refactors()
    end,
    desc = "[R]efactor",
    mode = { "n", "x" },
  },
  {
    "<leader>rpp",
    function()
      require("refactoring").debug.printf({ below = false })
    end,
    desc = "[P]rintf",
  },
  {
    "<leader>rpb",
    function()
      require("refactoring").debug.printf({ below = true })
    end,
    desc = "[P]rintf [Below]",
  },
  {
    "<leader>rv",
    function(...)
      lazyreq("refactoring").debug.print_var(...)
    end,
    desc = "Print [V]ar",
    mode = { "x", "n" },
  },
  {
    "<leader>rc",
    function(...)
      require("refactoring").debug.cleanup(...)
    end,
    desc = "[C]leanup",
  },
}

M.opts = {
  vimspector = {},
  import = {},
  undo = {
    side_by_side = true,
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.8,
    },
  },
  lazy = {},
  lazy_plugins = {
    lazy_config = vim.fn.stdpath("config") .. "/init.lua",
  },
  cheatsheet = {},
  lsp_handlers = {
    telescope = { require("telescope.themes").get_dropdown({}) },
  },
  refactoring = {},
  fzf = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = "smart_case",
  },
}

return M
