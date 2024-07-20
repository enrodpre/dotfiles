#!/usr/bin/lua

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require 'config.builtins'

require 'config.options'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'catppuccin' } },
  checker = { enabled = true },
  change_detection = { notify = false },
  dev = {
    path = vim.fn.getenv 'HOME' .. '/coding/nvim/plugins',
  },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rpmPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },
}

require 'config.autocmds'

require 'config.commands'
