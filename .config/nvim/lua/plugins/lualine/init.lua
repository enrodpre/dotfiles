return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'UiEnter',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require 'lualine_require'
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        component_separators = '|',
        -- section_separators = "",
      },
      extensions = { 'mason', 'lazy', 'quickfix' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diagnostics' },
        lualine_c = {
          'filename',
          {
            function()
              return require('NeoComposer.ui').status_recording()
            end,
            cond = function()
              return package.loaded['NeoComposer'] and true or false
            end,
          },
        },
        lualine_x = {
          'encoding',
          'filetype',
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return vim.lua.fn.fg("Debug") end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return vim.lua.fn.fg("Special") end,
          },
        },
        lualine_y = {
          "vim.fn.line('$')",
        },
        lualine_z = { 'location' },
      },
    }

    -- local trouble = require 'trouble'
    -- local symbols = trouble.statusline
    --   and trouble.statusline {
    --     mode = 'lsp_document_symbols',
    --     groups = {},
    --     title = false,
    --     filter = { range = true },
    --     format = '{kind_icon}{symbol.name:Normal}',
    --     hl_group = 'lualine_c_normal',
    --   }
    -- table.insert(opts.sections.lualine_x, {
    --   symbols and symbols.get,
    --   cond = symbols and symbols.has,
    -- })

    return opts
  end,
}
