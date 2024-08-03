#!/usr/bin/lua
local M = {
  {
    "mboughaba/i3config.vim",
    ft = "i3config",
  },
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },
}

local function add_plugins(specs, _module)
  for _, plugin in ipairs(require(_module)) do
    table.insert(specs, plugin)
  end
end

add_plugins(M, "plugins.filetypes.cpp")
add_plugins(M, "plugins.filetypes.lua")
add_plugins(M, "plugins.filetypes.cmake")
add_plugins(M, "plugins.filetypes.python")
return M
