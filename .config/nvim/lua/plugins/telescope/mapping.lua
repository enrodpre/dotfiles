#!/usr/bin/lua

local tb = vim.lua.lazyreq.on_exported_call 'telescope.builtin'
return {
  {
    'gf?',
    tb.oldfiles,
    desc = '[?] Go recently opened files',
  },
  {
    'g<leader>',
    tb.buffers,
    desc = '[ ] Find existing buffers',
  },
  {
    '<leader>fb',
    function()
      tb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    desc = '[F]uzzily search in current [B]uffer',
  },
  {
    'gff',
    tb.find_files,
    desc = '[G]o [F]ind [F]iles',
  },
  {
    '<leader>fg',
    tb.live_grep,
    desc = '[G]o [G]rep',
  },
  {
    'gh',
    tb.help_tags,
    desc = '[G]o [H]elp',
  },
  {
    '<leader>fgw',
    tb.grep_string,
    desc = '[F]ind by [G]rep current [W]ord',
  },
  {
    '<leader>gf',
    tb.git_files,
    desc = '[G]it [F]iles',
  },
  {
    '<leader>fgg',
    ':LiveGrepGitRoot<cr>',
    desc = '[F]ind by [G]rep on [G]it root',
  },
  {
    '<leader>ll',
    ':Telescope lazy<CR>',
    desc = '[L]azy',
  },
  {
    '<leader>lp',
    ':Telescope lazy_plugins<CR>',
    desc = '[P]lugins',
  },
  {
    '<leader>lc',
    -- ":Telescope content<CR>",
    function()
      require('telescope._extensions.content').exports.content()
    end,
    desc = '[C]ontent',
  },
  {
    '<leader>tb',
    tb.builtin,
    desc = '[T]elescope [B]uiltins',
  },
  {
    '<leader>tr',
    tb.resume,
    desc = '[T]elescope [R]esume',
  },
  {
    '<leader>tc',
    ':Cheatsheet<CR>:',
    desc = '[T]elescope [C]heatsheet',
  },
  {
    '<leader>nn',
    function()
      vim.lua.lazyreq.on_module_call('plugins.telescope.pickers').choose_neogen()
    end,
    desc = '[N]eogen',
  },
}
