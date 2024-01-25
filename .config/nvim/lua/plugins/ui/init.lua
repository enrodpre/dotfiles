local U = {
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    "fladson/vim-kitty",
    ft = 'kitty'
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
    opts = {
      style = "night"
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    "mboughaba/i3config.vim",
    ft = 'i3config'
  },
  {
    "AlphaTechnolog/pywal.nvim",
    event = 'UiEnter',
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        view = "cmdline_popup",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      popupmenu = {
        backend = "nui"
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      mini = {
        -- timeout = false,
      },
      messages = {
        -- view = "popup"
      }
    },
  },
  {
    "rktjmp/lush.nvim",
    cmd = "LushRunTutorial",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 800
    end,
    opts = {
      triggers_blacklist = {
        n = { "o", "oo" },
      },
    },
    config = function()
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>W'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['o'] = { 'which_key_ignore' },
        ['oo'] = { 'which_key_ignore' },
        ['O'] = { 'which_key_ignore' },
        ['OO'] = { 'which_key_ignore' },
      }
      require('which-key').register({
        ['<leader>'] = { name = 'VISUAL <leader>' },
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
    end
  },
}

local plugins = { "gitsigns" }

for _, plugin in ipairs(plugins) do
  table.insert(U, require('plugins.ui.' .. plugin))
end

return U
