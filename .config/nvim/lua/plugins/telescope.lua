local is_inside_work_tree = {}
local project_files = function()
  local opts = { hidden = true }
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end
  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

local function require_on_exported_call(mod)
  return setmetatable({}, {
    __index = function(_, picker)
      return function(...)
        return require(mod)[picker](...)
      end
    end,
  })
end
local function require_on_exported_call_with_params(mod, opts_table)
  return setmetatable({}, {
    __index = function(_, picker)
      return function(...)
        local opts = nil
        if opts_table ~= nil then
          opts = opts_table[picker]
        end

        if opts == nil then
          return require(mod)[picker](...)
        else
          opts = vim.tbl_deep_extend('force', opts, { ... })
          return require(mod)[picker](opts)
        end
      end
    end,
  })
end

local tbl_opts = {
  find_files = { results_title = vim.uv.cwd() },
}

local telescope = require_on_exported_call('telescope.builtin')
local mapping = {
  {
    "<leader>ff",
    telescope.find_files,
    desc = "[F]ind [F]iles",
  },
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
    function()
      local t = require("telescope")
      for k, _ in pairs(t.extensions) do
        t.load_extension(k)
      end
    end,
    desc = "[T]elescope",
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
    telescope.current_buffer_fuzzy_find,
    desc = "[F]uzzily search in current [B]uffer",
  },
  {
    "<leader>fg",
    telescope.live_grep,
    desc = "[F]ind [G]rep",
  },
  {
    "gh",
    telescope.help_tags,
    desc = "[G]o [H]elp",
  },
  {
    "<leader>tb",
    telescope.builtin,
    desc = "[T]elescope [B]uiltins",
  },
  {
    "<leader>tk",
    telescope.keymaps,
    desc = "[T]elescope [K]eymaps",
  },
}

local function show_two_parent_dirs(path)
  -- Get the absolute path
  local abs_path = vim.fn.fnamemodify(path, ":p")

  -- Get the last two parent directories
  local parent_dirs = vim.fn.fnamemodify(abs_path, ":h:h") -- Get the grandparent directory
  local last_dir = vim.fn.fnamemodify(abs_path, ":h")      -- Get the parent directory

  -- Combine the last two directories
  local result = vim.fn.fnamemodify(parent_dirs, ":t") .. "/" .. vim.fn.fnamemodify(last_dir, ":t")

  return '.../' .. result .. '/'
end

local go_up_cwd_find_files = function(prompt)
  local current_picker = require("telescope.actions.state").get_current_picker(
    prompt)
  if current_picker == nil then return end
  -- cwd is only set if passed as telescope option
  local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.uv.cwd()

  local parent_dir = vim.fs.dirname(cwd)
  local formatted_parent = show_two_parent_dirs(parent_dir)
  require("telescope.actions").close(prompt)
  require("telescope.builtin").find_files {
    cwd = parent_dir,
    results_title = formatted_parent
  }
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
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
    -- Dependencies
    { "nvim-treesitter/nvim-treesitter", },
    { "nvim-lua/plenary.nvim", },
  },
  keys         = mapping,
  lazy         = true,
  opts         = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = "close",
        },
      },
    },
    extensions = {
      aerial = {
        -- Set the width of the first two columns (the second
        -- is relevant only when show_columns is set to 'both')
        col1_width = 4,
        col2_width = 30,
        -- How to format the symbols
        format_symbol = function(symbol_path, filetype)
          if filetype == "json" or filetype == "yaml" then
            return table.concat(symbol_path, ".")
          else
            return symbol_path[#symbol_path]
          end
        end,
        -- Available modes: symbols, lines, both
        show_columns = "both",
      },
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
      -- lsp_handlers = {
      --   telescope = { require("telescope.themes").get_dropdown({}), },
      -- },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      -- macros = {},
    },
    pickers = {
      find_files = {
        results_title = show_two_parent_dirs(vim.uv.cwd()),
        hidden = false,
        mappings = {
          i = {
            ["<C-b>"] = go_up_cwd_find_files,
          },
        },
      },
    },
  },
}
