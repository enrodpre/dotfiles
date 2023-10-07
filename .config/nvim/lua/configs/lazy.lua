-- Boostrap lazy plugin
local LazyConfig = {
  defaults = {
    lazy = true,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  checker = {
    enabled = true,
  },
  performance = {
    rtp = {
      disabled_plugin = {
        "which-key",
        "tutor"
      },
    },
  },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })

  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", LazyConfig)
