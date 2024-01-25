#!/usr/bin/lua

local go_up_cwd_find_files = function(prompt)
  local current_picker =
      require("telescope.actions.state").get_current_picker(prompt)
  -- cwd is only set if passed as telescope option
  local cwd = current_picker.cwd and tostring(current_picker.cwd)
      or vim.loop.cwd()
  local parent_dir = vim.fs.dirname(cwd)

  require("telescope.actions").close(prompt)
  require("telescope.builtin").find_files {
    prompt_title = parent_dir,
    cwd = parent_dir,
    hidden = true,
  }
end

local telescope = require('telescope')

telescope.setup {
  pickers = {
    find_files = {
      mappings = {
        i = {
          ["<C-u>"] = go_up_cwd_find_files
        }
      },
      prompt_title = vim.loop.cwd()
    }
  }
}

require('mappings.telescope')
local telescope_extensions = {
  "fzf",
  -- 'noice',
  -- "cheat",
}

for _, ext in ipairs(telescope_extensions) do
  pcall(telescope.load_extension(ext))
end
