#!/usr/bin/lua

---@alias IconGetter fun(string,string):string
---@alias IconLister fun(string):string[]
---@alias IconProvider fun():{get:IconGetter,list:IconLister}

---@class Config
---@field colorscheme string|table<string>
---@field scripts { [string]: table<boolean, integer> }
---@field icons IconProvider[]
---@field lazy LazyConfig
return {
  colorscheme = { "catppuccin" },
  scripts = {
    lazy = { enabled = true, priority = 80 },
    autocmds = { enabled = true, priority = 30 },
    builtins = { enabled = true, priority = 90 },
    options = { enabled = true, priority = 100 },
    commands = { enabled = true, priority = 40 },
  },
  icons = {
    function()
      local prov = require("nvim-web-devicons")
      return { get = prov.get_icon, list = prov.list }
    end,
    function()
      local prov = require("mini.icons")
      return { get = prov.get, list = prov.list }
    end,
    function()
      local fallback_icons = {
        misc = {
          dots = "󰇘",
        },
        ft = {
          octo = "",
        },
        dap = {
          Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
          Breakpoint = " ",
          BreakpointCondition = " ",
          BreakpointRejected = { " ", "DiagnosticError" },
          LogPoint = ".>",
        },
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
        git = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        kinds = {
          Array = " ",
          Boolean = "󰨙 ",
          Class = " ",
          Codeium = "󰘦 ",
          Color = " ",
          Control = " ",
          Collapsed = " ",
          Constant = "󰏿 ",
          Constructor = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = "󰊕 ",
          Interface = " ",
          Key = " ",
          Keyword = " ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = " ",
          Number = "󰎠 ",
          Object = " ",
          Operator = " ",
          Package = " ",
          Property = " ",
          Reference = " ",
          Snippet = " ",
          String = " ",
          Struct = "󰆼 ",
          TabNine = "󰏚 ",
          Text = " ",
          TypeParameter = " ",
          Unit = " ",
          Value = " ",
          Variable = "󰀫 ",
        },
      }

      local list = function(group)
        return fallback_icons[group]
      end
      local get = function(group, elem)
        return list(group)[elem]
      end

      return { list = list, get = get }
    end,
  },
  lazy = {
    checker = { enabled = false },
    change_detection = { notify = false },
    defaults = { lazy = true },
    dev = {
      path = vim.fn.getenv("HOME") .. "/coding/nvim/plugins",
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "rpmPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    profiling = {
      loader = false,
      require = false,
    },
    spec = {
      { import = "plugins" },
    },
  },
}
