#!/usr/bin/lua

local config = function(_, opts)
  local focused = true

  vim.api.nvim_create_autocmd('FocusGained', {
    callback = function()
      focused = true
    end,
  })
  vim.api.nvim_create_autocmd('FocusLost', {
    callback = function()
      focused = false
    end,
  })

  -- table.insert(opts.routes, 1, {
  --    filter = {
  --       ["not"] = {
  --          event = "lsp",
  --          kind = "progress",
  --       },
  --       cond = function()
  --          return not focused
  --       end,
  --    },
  --    view = "notify_send",
  --    opts = { stop = false, },
  -- })
  require('noice').setup(opts)
end

return {
  'folke/noice.nvim',
  event = 'UiEnter',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = config,
  opts = {
    cmdline = { view = 'cmdline_popup' },
    commands = {
      history = {
        view = 'popupmenu',
      },
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    messages = {
      view_search = false,
    },
    popupmenu = { backend = 'cmp' },
    presets = {
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = 'search_count',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'notify',
          find = 'No code actions available',
        },
        opts = { skip = false },
      },
      {
        filter = {
          event = 'notify',
          find = 'Tag not found',
        },
        opts = { skip = false },
      },
      {
        filter = {
          event = 'notify',
          find = 'No tags file',
        },
        opts = { skip = false },
      },
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    views = {
      cmdline_popup = {
        position = {
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 8,
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
        },
      },
    },
  },
}
