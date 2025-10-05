require("options")
require("filetype")
require("functions")

local lazy_installed = vim.uv.fs_stat(vim.fn.stdpath("data") .. "lazy/lazy.nvim")
if not lazy_installed then
  load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()
end

require("lazy").setup({ { import = "plugins", }, }, {
  dev = {
    path = "~/dev/nvim/plugins",
    patterns = { "cmake-tools.nvim" },
    fallback = true
  },
  defaults = { lazy = true, },
  -- install = { colorscheme = { "catppuccin", }, },
  rocks = { root = "/home/kike/.local/lib/luarocks/rocks-5.1", },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    reset = true,
    reset_packpath = false,
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
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },
})

vim.cmd [[packadd nohlsearch]]
-- vim.print = vim.notify
require("autocmds")
require("library")
require("library.gdb")
require("library.autosource")
require("commands")
