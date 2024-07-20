#!/usr/bin/env lua

local tb = vim.lua.lazyreq.on_exported_call 'telescope.builtin'
local ta = vim.lua.lazyreq.on_exported_call 'telescope.actions'

local go_up_cwd_find_files = function(prompt)
  local current_picker = require('telescope.actions.state').get_current_picker(prompt)
  -- cwd is only set if passed as telescope option
  local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.loop.cwd()
  local parent_dir = vim.fs.dirname(cwd)

  require('telescope.actions').close(prompt)
  require('telescope.builtin').find_files {
    prompt_title = parent_dir,
    cwd = parent_dir,
    hidden = true,
  }
end

-- local pickers = vim.lua.lazyreq.on_exported_call 'plugins.telescope.pickers'
-- local extensions = require 'plugins.telescope.extensions'

-- TODO
-- M = extensions

T = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = require 'plugins.telescope.mapping',
  event = 'VeryLazy',
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<esc>'] = ta.close,
        },
      },
    },
    -- extensions = M.opts,
    pickers = {
      prompt_title = vim.loop.cwd(),
      find_files = {
        mappings = {
          i = {
            ['<C-u>'] = go_up_cwd_find_files,
          },
        },
      },
    },
  },
}

-- table.remove(M, opts)
-- table.insert(M, T)

return T
