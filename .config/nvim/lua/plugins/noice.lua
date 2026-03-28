return {
  "folke/noice.nvim",
  enabled = true,
  event = "UiEnter",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    cmdline = {
      view = "cmdline",
      { "<C-d>", "<Down>", desc = "Go more recent on cmdline history", mode = "c", noremap = true, },
      { "<C-u>", "<Up>",   desc = "Go more old on cmdline history",    mode = "c", noremap = true, },
    },
    commands = {
      history = {
        view = "split",
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    messages = {
      view_history = "popup",
      view_search = false,
    },
    notify = { enabled = true },
    popupmenu = { backend = "nui", },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = false,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "search_count",
        },
        opts = { skip = true, },
      },
      {
        filter = {
          event = "notify",
          find = "Tag not found",
        },
        opts = { skip = false, },
      },
      {
        filter = {
          event = "notify",
          find = "No tags file",
        },
        opts = { skip = false, },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B", },
            { find = "; after #%d+", },
            { find = "; before #%d+", },
          },
        },
        view = "mini",
      },
    },
    views = {
      cmdline_popup = {
        position = {
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 0,
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
}
