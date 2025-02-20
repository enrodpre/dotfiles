local mapping = {
  {
    "<leader>rp",
    group = "[R]efactoring [P]rintf",
  },
  {
    "<leader>r",
    group = "[R]efactoring",
  },
  {
    "<leader>tc",
    "<cmd>Cheatsheet<CR>:",
    desc = "[T]elescope [C]heatsheet",
  },
  {
    "<leader>tll",
    "<cmd>Telescope lazy<CR>",
    desc = "[O]pen [L]azy",
  },
  {
    "<leader>tlp",
    "<cmd>Telescope lazy_plugins<CR>",
    desc = "[O]pen [L]azy [P]lugins",
  },
  {
    "glr",
    "<cmd>Telescope lsp_references<CR>",
    desc = "[R]eferences",
  },
  {
    "gld",
    "<cmd>Telescope lsp_definitions<CR>",
    desc = "[D]efinitions",
  },
  {
    "gli",
    "<cmd>Telescope lsp_implementations<CR>",
    desc = "[I]mplementations",
  },
  {
    "<leader>rr",
    vim.lsp.buf.rename,
    desc = "[R]ename",
  },
  {
    "<leader>re",
    function(...)
      require("telescope").extensions.refactoring.refactors(...)
    end,
    desc = "[R]efactor",
    mode = { "n", "x", },
  },
  {
    "<leader>rpp",
    function()
      require("refactoring").debug.printf({ below = false, })
    end,
    desc = "[P]rintf",
  },
  {
    "<leader>rpb",
    function()
      require("refactoring").debug.printf({ below = true, })
    end,
    desc = "[P]rintf [Below]",
  },
  {
    "<leader>rv",
    function(...)
      require("refactoring").debug.print_var(...)
    end,
    desc = "Print [V]ar",
    mode = { "x", "n", },
  },
  {
    "<leader>rc",
    function(...)
      require("refactoring").debug.cleanup(...)
    end,
    desc = "[C]leanup",
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
    "<S-CR>",
    function()
      require("noice").redirect(vim.fn.getcmdline())
    end,
    desc = "Redirect output of command line",
    mode = "c",
  },
  {
    "<leader>fb",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require(
        "telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    desc = "[F]uzzily search in current [B]uffer",
  },
  {
    "<leader>ff",
    function(...)
      require("telescope.builtin").find_files(...)
    end,
    desc = "[F]ind [F]iles",
  },
  {
    "<leader>fg",
    function(...)
      require("telescope.builtin").live_grep(...)
    end,
    desc = "[G]o [G]rep",
  },
  {
    "gh",
    function(...)
      require("telescope.builtin").help_tags(...)
    end,
    desc = "[G]o [H]elp",
  },
  {
    "<leader>fgw",
    function(...)
      require("telescope.builtin").grep_string(...)
    end,
    desc = "[F]ind by [G]rep current [W]ord",
  },
  {
    "<leader>gf",
    function(...)
      require("telescope.builtin").git_files(...)
    end,
    desc = "[G]it [F]iles",
  },
  {
    "<leader>fgg",
    "<cmd>LiveGrepGitRoot<cr>",
    desc = "[F]ind by [G]rep on [G]it root",
  },
  {
    "<leader>tb",
    function()
      require("telescope.builtin").builtin()
    end,
    desc = "[T]elescope [B]uiltins",
  },
  {
    "<leader>tk",
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "[T]elescope [K]eymaps",
  },
}

local go_up_cwd_find_files = function(prompt)
  local current_picker = require("telescope.actions.state").get_current_picker(
    prompt)
  if not current_picker then return end

  -- cwd is only set if passed as telescope option
  local cwd = current_picker.cwd and tostring(current_picker.cwd)
  local parent_dir = vim.fs.dirname(cwd)

  require("telescope.actions").close(prompt)
  require("telescope.builtin").find_files({
    prompt_title = parent_dir,
    cwd = parent_dir,
    hidden = true,
  })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "debugloop/telescope-undo.nvim",      cmd = "Telescope undo", },
    {
      "piersolenski/telescope-import.nvim",
      cmd = "Telescope import",
    },
    { "LinArcX/telescope-scriptnames.nvim", cmd = "Telescope scripts", },
    {
      "tsakirist/telescope-lazy.nvim",
      cmd = "Telescope lazy",
    },
    -- {
    --   "polirritmico/telescope-lazy-plugins.nvim",
    --   cmd = "Telescope plugins",
    -- },
    {
      "doctorfree/cheatsheet.nvim",
      cmd = "Telescope cheatsheet",
      dependencies = { "nvim-lua/popup.nvim", },
    },
    { "gbrlsnchs/telescope-lsp-handlers.nvim", cmd = "Telescope lsp", },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      event = "VeryLazy",
      build =
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    -- Dependencies
    { "nvim-treesitter/nvim-treesitter", },
    { "nvim-lua/plenary.nvim", },
  },
  keys         = mapping,
  config       = function(_, o)
    local telescope = require("telescope")
    telescope.setup(o)
  end,
  opts         = function()
    local actions = require("telescope.actions")
    local ret = {
      defaults = { mappings = { i = { ["<esc>"] = actions.close, }, }, },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
        -- lazy_plugins = {
        --   lazy_config = vim.fn.stdpath("config") .. "/init.lua",
        -- },
        lsp_handlers = {
          telescope = { require("telescope.themes").get_dropdown({}), },
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      pickers = {
        prompt_title = (vim.uv.cwd() or vim.loop.cwd()),
        find_files = {
          mappings = {
            i = {
              ["<C-b>"] = go_up_cwd_find_files,
            },
          },
        },
      },
    }
    return ret
  end,
}
