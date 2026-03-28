require("options")
require("functions")
require("lazy-nvim")
require("library")

vim.cmd([[packadd nohlsearch]])
vim.cmd('colorscheme ' .. vim.g.colorscheme)
