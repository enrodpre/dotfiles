return {
  {
    'ecthelionvi/NeoComposer.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    lazy = true,
    keys = { 'q' },
    opts = { notify = false },
  },
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = {
      timeoutlen = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = { k = { j = '<Esc>' } },
      },
    },
  },
  {
    'monaqa/dial.nvim',
    event = 'VeryLazy',
    config = function()
      local manipulate = require('dial.map').manipulate
      local data = {
        {
          'n',
          '<C-a>',
          'increment',
          'normal',
        },
        {
          'n',
          '<C-x>',
          'decrement',
          'normal',
        },
        {
          'n',
          'g<C-a>',
          'increment',
          'gnormal',
        },
        { 'n', 'g<C-x>', 'decrement', 'gnormal' },
        { 'v', '<C-a>', 'increment', 'visual' },
        { 'v', '<C-x>', 'decrement', 'visual' },
        { 'v', 'g<C-a>', 'increment', 'gvisual' },
        { 'v', 'g<C-x>', 'decrement', 'gvisual' },
      }

      for _, row in ipairs(data) do
        local modo, lhs, dir, rhs = unpack(row)
        vim.keymap.set(modo, lhs, function()
          manipulate(dir, rhs)
        end)
      end

      local augend = require 'dial.augend'

      local default_augend = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
      }

      local create_autogends = function(list, word)
        word = word or true
        for _, pair in ipairs(list) do
          table.insert(
            default_augend,
            augend.constant.new {
              elements = pair,
              preserve_case = true,
              word = true,
              cyclic = true,
            }
          )
        end
      end

      local new_augends = {
        {
          { 'and', 'or' },
          { 'always', 'never' },
          { 'false', 'true' },
          { 'False', 'True' },
          { 'horizontal', 'vertical' },
          { 'yes', 'no' },
        },
        {
          { '&', '|' },
          { '&&', '||' },
          { '+', '-' },
          { '==', '!=' },
        },
      }

      local words, tokens = unpack(new_augends)
      create_autogends(words)
      create_autogends(tokens, false)

      require('dial.config').augends:register_group { default = default_augend }
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      local pairs = require 'mini.pairs'
      pairs.setup(opts)
      local open = pairs.open
      pairs.open = function(pair, neigh_pattern)
        if vim.fn.getcmdline() ~= '' then
          return open(pair, neigh_pattern)
        end
        local o, c = pair:sub(1, 1), pair:sub(2, 2)
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])
        if opts.markdown and o == '`' and vim.bo.filetype == 'markdown' and before:match '^%s*``' then
          return '`\n```' .. vim.api.nvim_replace_termcodes('<up>', true, true, true)
        end
        if opts.skip_next and next ~= '' and next:match(opts.skip_next) then
          return o
        end
        if opts.skip_ts and #opts.skip_ts > 0 then
          local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
          for _, capture in ipairs(ok and captures or {}) do
            if vim.tbl_contains(opts.skip_ts, capture.capture) then
              return o
            end
          end
        end
        if opts.skip_unbalanced and next == c and c ~= o then
          local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), '')
          local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), '')
          if count_close > count_open then
            return o
          end
        end
        return open(pair, neigh_pattern)
      end
    end,
  },
  -- {
  --   "ggandor/leap.nvim",
  --   config = function()
  --     require('leap').create_default_mappings()
  --   end
  -- },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'InsertEnter',
    config = true,
  },
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- {
  --   'windwp/nvim-autopairs',
  --   dependencies = {
  --     'hrsh7th/nvim-cmp',
  --   },
  --   event = 'InsertEnter',
  --   opts = {
  --     enable_check_bracket_line = true,
  --   },
  -- },
}
