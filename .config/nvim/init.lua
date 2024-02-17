vim.g.mapleader = " "
vim.g.maplocalleader = " "

local functions = require("util.functions")

vim.lua = {}
for name, func in pairs(functions) do vim.lua[name] = func end

vim.lua.metatables = {}
local metatables = require("util.metatables")
for name, func in pairs(metatables) do vim.lua.metatables[name] = func end

local confpath = os.getenv("XDG_CONFIG_HOME") .. "/" .. "config.yaml"
vim.cfg = require("config").read_config(confpath).neovim

local debug = require("util.debug")
vim.print = debug.dump

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazyopts =    {
  default = { lazy = true },
  config = {
    env = { path = "~/coding/nvim/plugins" },
  },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",     -- "matchit",         -- "matchparen",
        "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
}

require("lazy").setup("plugins", lazyopts)

require("options")

require("autocmds")

require("user_functions")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
