#!/usr/bin/env lua

local tb = vim.lua.lazyreq.on_exported_call("telescope.builtin")
local ta = vim.lua.lazyreq.on_exported_call("telescope.actions")

local go_up_cwd_find_files = function(prompt)
  local current_picker = require("telescope.actions.state").get_current_picker(prompt)
  -- cwd is only set if passed as telescope option
  local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.loop.cwd()
  local parent_dir = vim.fs.dirname(cwd)

  require("telescope.actions").close(prompt)
  require("telescope.builtin").find_files({
    prompt_title = parent_dir,
    cwd = parent_dir,
    hidden = true,
  })
end

-- local pickers = vim.lua.lazyreq.on_exported_call 'plugins.telescope.pickers'
local extensions = require("plugins.telescope.extensions")

local keymaps = require("plugins.telescope.mapping")
for _, keymap in ipairs(extensions.keymaps) do
  table.insert(keymaps, keymap)
end

T = {
  "nvim-telescope/telescope.nvim",
  dependencies = extensions.specs,
  keys = keymaps,
  event = "VeryLazy",
  config = function(_, o)
    local telescope = require("telescope")
    telescope.setup(o)

    --- Load extensions
    for name, _ in pairs(o.extensions) do
      telescope.load_extension(name)
    end
  end,
  opts = {
    defaults = { mappings = { i = { ["<esc>"] = ta.close } } },
    extensions = extensions.opts,
    pickers = {
      prompt_title = vim.loop.cwd(),
      find_files = {
        mappings = {
          i = {
            ["<C-b>"] = go_up_cwd_find_files,
          },
        },
      },
    },
  },
}

return T
