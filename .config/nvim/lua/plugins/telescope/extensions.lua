#!/usr/bin/lua

local lazy_load_extension = vim.lua.fn.lazy_load_extension

M = {}

M.extensions = {
  {
    'enrodpre/telescope-content.nvim',
    enabled = false,
    dev = true,
    cmd = 'Telescope content',
  },
  {
    'tsakirist/telescope-lazy.nvim',
    cmd = 'Telescope lazy',
  },
  {
    'polirritmico/telescope-lazy-plugins.nvim',
    cmd = 'Telescope lazy_plugins',
  },
  {
    'doctorfree/cheatsheet.nvim',
    cmd = 'Telescope cheatsheet',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = 'VeryLazy',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    init = lazy_load_extension 'fzf',
  },
}

M.opts = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath 'config' .. '/init.lua',
  },
  fzf = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = 'smart_case',
  },
}

return M
