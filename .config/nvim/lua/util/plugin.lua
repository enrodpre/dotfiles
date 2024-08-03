#!/usr/bin/lua

local plugin = require("lazy.core.plugin")

---@class lazyvim.util.plugin
local m = {}

---@type string[]
m.core_imports = {}

m.lazy_file_events = { "bufreadpost", "bufnewfile", "bufwritepre" }

---@type table<string, string>
m.renames = {
  ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
  ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
  ["null-ls.nvim"] = "none-ls.nvim",
  ["romgrk/nvim-treesitter-context"] = "nvim-treesitter/nvim-treesitter-context",
  ["glepnir/dashboard-nvim"] = "nvimdev/dashboard-nvim",
}

function m.save_core()
  if vim.v.vim_did_enter == 1 then
    return
  end
  m.core_imports = vim.deepcopy(require("lazy.core.config").spec.modules)
end

function m.setup()
  m.fix_imports()
  m.fix_renames()
  m.lazy_file()
end

function m.extra_idx(name)
  local config = require("lazy.core.config")
  for i, extra in ipairs(config.spec.modules) do
    if extra == "lazyvim.plugins.extras." .. name then
      return i
    end
  end
end

function m.lazy_file()
  -- this autocmd will only trigger when a file was loaded from the cmdline.
  -- it will render the file as quickly as possible.
  vim.api.nvim_create_autocmd("bufreadpost", {
    once = true,
    callback = function(event)
      -- skip if we already entered vim
      if vim.v.vim_did_enter == 1 then
        return
      end

      -- try to guess the filetype (may change later on during neovim startup)
      local ft = vim.filetype.match({ buf = event.buf })
      if ft then
        -- add treesitter highlights and fallback to syntax
        local lang = vim.treesitter.language.get_lang(ft)
        if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
          vim.bo[event.buf].syntax = ft
        end

        -- trigger early redraw
        vim.cmd([[redraw]])
      end
    end,
  })

  -- add support for the lazyfile event
  local event = require("lazy.core.handler.event")

  event.mappings.lazyfile = { id = "lazyfile", event = m.lazy_file_events }
  event.mappings["user lazyfile"] = event.mappings.lazyfile
end

function m.fix_imports()
  plugin.spec.import = lazyvim.inject.args(plugin.spec.import, function(_, spec)
    local dep = m.deprecated_extras[spec and spec.import]
    if dep then
      dep = dep .. "\n" .. "please remove the extra from `lazyvim.json` to hide this warning."
      lazyvim.warn(dep, { title = "lazyvim", once = true, stacktrace = true, stacklevel = 6 })
      return false
    end
  end)
end

function m.fix_renames()
  plugin.spec.add = lazyvim.inject.args(plugin.spec.add, function(self, plugin)
    if type(plugin) == "table" then
      if m.renames[plugin[1]] then
        lazyvim.warn(
          ("plugin `%s` was renamed to `%s`.\nplease update your config for `%s`"):format(plugin[1], m.renames[plugin[1]], self.importing or "lazyvim"),
          { title = "lazyvim" }
        )
        plugin[1] = m.renames[plugin[1]]
      end
    end
  end)
end

return m
