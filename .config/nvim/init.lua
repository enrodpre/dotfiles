vim.cmd("set termguicolors")

-- Execute the startup modules
require("options").load()
require("autocmds").load()
require("mappings").load()
require('configs.lazy')

local path = {}

path.data = "/mason/bin"

for std, p in pairs(path) do
  vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath(std) .. p
end

vim.cmd("colorscheme pywal")
