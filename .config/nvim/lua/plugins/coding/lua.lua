#!/usr/bin/lua

return { 
  { 'folke/neodev.nvim', config = function() end },
  {
    'folke/lazydev.nvim',
    ft='lua',
    opts = function(_, opts)
      opts.library = opts.library or {}
      table.insert(opts.library, {
        'luvit-meta',
        'lazy.nvim',
        'neodev.nvim/types/stable',
      })
      return opts
    end,
  },
  {
    'Bilal2453/luvit-meta',
    lazy = true,
  }, 
  {
    'danymat/neogen',
    lazy = true,
    config = true,
    keys = { '<leader>n' },
  },
  {
    'jbyuki/one-small-step-for-vimkind',
    lazy = true,
    keys = { '<leader>b', '<leader>B', '<F5>', },
    config = function(opts)
      local dap = require 'dap'
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance',
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback {
          type = 'server',
          host = config.host or '127.0.0.1',
          port = config.port or 8086,
        }
      end

      --vim.api.nvim_set_keymap('n', '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
      --vim.api.nvim_set_keymap('n', '<leader>e', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })

    end,
  },
}
