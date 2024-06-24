#!/usr/bin/lua

local config = function(opts)
   local focused = true

   vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
         focused = true
      end,
   })
   vim.api.nvim_create_autocmd("FocusLost", {
      callback = function()
         focused = false
      end,
   })

   table.insert(opts.routes or {}, 1, {
      filter = {
         ["not"] = {
            event = "lsp",
            kind = "progress",
         },
         cond = function()
            return not focused
         end,
      },
      view = "notify_send",
      opts = { stop = false, },
   })
end

return {
   "folke/noice.nvim",
   enabled = vim.cfg.noice.enabled,
   event = "VeryLazy",
   dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
   },
   opts = {
      cmdline = { view = "cmdline_popup", },
      commands = {
         history = {
            view = "popupmenu",
         },
      },
      lsp = {
         override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
         },
      },
      popupmenu = { backend = "nui", },
      presets = {
         bottom_search = true,         -- use a classic bottom cmdline for search
         command_palette = false,      -- position the cmdline and popupmenu together
         long_message_to_split = true, -- long messages will be sent to a split
         inc_rename = false,           -- enables an input dialog for inc-rename.nvim
         lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      views = {
         cmdline_popup = {
            position = {
               row = 5,
               col = "50%",
            },
            size = {
               width = 60,
               height = "auto",
            },
         },
         popupmenu = {
            -- relative = "editor",
            position = {
               row = 8,
               col = "50%",
            },
            size = {
               width = 60,
               height = 10,
            },
            border = {
               style = "rounded",
               padding = { 0, 1, },
            },
            win_options = {
               winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo", },
            },
         },
      },
   },
   config = config,
}
