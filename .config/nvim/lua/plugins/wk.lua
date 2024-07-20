#!/usr/bin/lua

local mapdelay = vim.lua.metatables.default()
local disablemap = vim.lua.metatables.default()

local global_mapping = {
  -- Disable
  { 'gc', cond = false },
  --Enable
  {
    '<C-o>',
    'a<CR><Esc>',
    desc = 'Put next line in next character',
  },
  {
    '<C-:>',
    ':lua=',
    desc = 'Open cmdline directly in lua mode',
  },
  {
    'oo',
    'o<Esc>k',
    desc = 'Newline forward',
    hidden = true,
  },
  {
    'OO',
    '0i<CR><Esc>',
    desc = 'Newline backwards',
    hidden = true,
  },
  {
    '<C-Q>',
    ':q <CR>',
    desc = 'Quit neovim',
    noremap = false,
  },
  {
    '<leader>s',
    group = '[S]et',
  },
  {
    'gl',
    group = '[G]o [L]sp',
  },
  {
    '<leader>w',
    group = '[W]orkspace',
  },
  {
    '<leader>x',
    group = '[X] Trouble',
  },
  {
    '<leader>rp',
    group = '[P]rintf',
  },
  {
    '<leader>r',
    group = '[R]efactoring',
  },
  {
    '<leader>c',
    group = '[C]omment',
  },
  {
    'gd',
    group = '[G]o [D]ocument',
  },
  {
    '<C-Q><C-Q>',
    ':q! <CR>',
    desc = 'Force quit',
  },
  {
    '<leader>f',
    group = '[F]ind',
  },
  {
    '<leader>fg',
    group = '[G]rep',
  },
  {
    '<C-s>',
    '<cmd>w<CR>',
    desc = 'Save',
  },
  {
    'g',
    group = '[G]o',
  },
  {
    'y:!<C-r>"<CR>',
    desc = 'Execute selected text in a terminal',
    mode = 'v',
  },
  {
    '<leader>t',
    group = '[T]elescope',
  },
  {
    '<leader>l',
    group = '[L]azy',
  },
  {
    '<S-CR>',
    function()
      require('noice').redirect(vim.fn.getcmdline())
    end,
    desc = 'Redirect output of command line',
    mode = 'c',
  },
  {
    '<Esc>',
    "<Esc>:let @/ = ''<CR>",
    desc = 'Escape will clear search pattern',
  },
  { '<leader>e', group = '[E]xecute' },
  {
    '<leader>ea',
    function()
      local ft = vim.bo.filetype
      if ft == 'python' then
        os.execute('autoimport ' .. vim.fn.expand '%:S')
        vim.cmd 'e'
      end
    end,
    desc = '[E]xecute [A]utoimport',
  },
  {
    '<leader>et',
    '<Plug>PlenaryTestFile',
    desc = '[T]est current file',
  },
  {
    '<leader>n',
    group = '[N]eogen',
  },
  {
    '<leader>nc',
    function()
      require('neogen').generate()
    end,
    desc = '[C]lass',
  },
  {
    '<leader>m',
    ':messages<CR>',
    desc = 'Open messages',
  },
  {
    '<leader>o',
    group = '[O]pen',
  },
  {
    '<leader>ol',
    function()
      require('lazy').show()
    end,
    desc = '[O]pen [L]azy',
  },
  {
    '<leader>u',
    group = '[U]i',
  },
  {
    '<leader>uc',
    function()
      require('notify').dismiss {}
    end,
    desc = 'Notify [C]lose',
  },
  {
    '<leader>g',
    group = '[G]it',
  },
}

table.insert(mapdelay, {
  n = {
    o = 25,
    O = 25,
    oo = 0,
    OO = 0,
  },
})

table.insert(disablemap, {
  n = {
    o = true,
    O = true,
    oo = true,
    OO = true,
  },
})

return {
  'folke/which-key.nvim',
  dependencies = {
    { 'echasnovski/mini.icons' },
  },
  event = 'VeryLazy',
  opts = {
    delay = function(ctx)
      return mapdelay[ctx.mode][ctx.keys] or ctx.plugin and 0 or 200
    end,
    preset = 'modern',
    spec = global_mapping,
    notify = false,
    trigger = function(ctx)
      return disablemap[ctx.mode][ctx.keys] or false
    end,
  },
}
