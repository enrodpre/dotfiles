#!/usr/bin/lua

local homepath = os.getenv "HOME"
local cmds = {}

cmds.reloadzsh = {
  event = "BufWritePost",
  pattern = homepath .. "/zsh/**",
  callback = function()
    os.execute "kitty +kittens broadcast reloadzsh"
  end,
}

cmds.reloadnvim = {
  event = "BufWritePost",
  pattern = homepath .. "/**",
  callback = function()
    vim.cmd(string.format("source %s/nvim/init.lua", os.getenv "XDG_CONFIG_HOME"))
    vim.notify "Configuration reloaded"
  end,
  desc = "Reload config on save",
}

return cmds
