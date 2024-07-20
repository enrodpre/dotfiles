local M = {
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  { 'tpope/vim-sleuth', event = 'BufReadPre' },
  {
    'echasnovski/mini.comment',
    version = false,
    keys = '<leader>c',
    opts = {
      mappings = {
        comment = '<leader>c',
        comment_line = '<leader>cc',
        comment_visual = '<leader>c',
        textobject = '<leader>c',
      },
    },
  },
  -- {
  --    "numToStr/Comment.nvim",
  --    lazy = true,
  --    keys = "<leader>c",
  --    opts = {
  --       toggler = {
  --          line = "<leader>cc",
  --          block = "<leader>cbc",
  --       }, ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  --       opleader = {
  --          ---Line-comment keymap
  --          line = "<leader>c",
  --          ---Block-comment keymap
  --          block = "<leader>b",
  --       },
  --       extra = {
  --          above = "<leader>cO",
  --          below = "<leader>cbo",
  --          eol = "<leader>cA",
  --       },
  --       mapping = {
  --          basic = false,
  --          extra = false,
  --       },
  --    },
  -- },
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-plenary',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-plenary',
        },
      }
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      vim.lua.fn.lazy_load_extension 'refactoring'
    end,
    opts = {
      prompt_func_return_type = {
        cpp = true,
        c = true,
        h = true,
        hpp = true,
      },
      prompt_func_param_type = {
        cpp = true,
        c = true,
        h = true,
        hpp = true,
      },
    },
  },
}

-- for filetype, _ in vim.lua.fn.list_submodules("plugins.coding") do
--    vim.api.nvim_create_autocmd("FileType", {
--       pattern = filetype,
--       callback = function()
--          vim.print("installing " .. filetype)
--          local plugins = require("plugins.coding." .. filetype)
--          require("lazy").install(plugins)
--          for _, ftplugin in plugins do
--             require("lazy").load(ftplugin)
--          end
--       end,
--       once = true,
--    })
-- end

local function add_plugins(specs, _module)
  for _, plugin in ipairs(require(_module)) do
    table.insert(specs, plugin)
  end
end

add_plugins(M, 'plugins.coding.lua')
add_plugins(M, 'plugins.coding.python')
add_plugins(M, 'plugins.coding.cpp')

return M
