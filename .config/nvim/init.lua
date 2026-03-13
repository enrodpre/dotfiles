require("options")
require("functions")
require("config").setup()
require("library.lang")

local lazy_installed = vim.uv.fs_stat(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not lazy_installed then
  load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()
end

require("lazy").setup({ { import = "plugins", }, }, {
  dev = {
    path = "~/dev/nvim/plugins",
    -- patterns = { "themery.nvim", "cmake-tools.nvim" },
    fallback = true
  },
  defaults = { lazy = true, },
  rocks = { root = "/home/kike/.local/lib/luarocks/rocks-5.1", },
  change_detection = {
    enabled = true,
    notify = false,
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
  profiling = { loader = true, require = true, },
})

require("library")

-- vim.packadd()
vim.cmd [[packadd nohlsearch]]
