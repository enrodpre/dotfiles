local treesitter = require("library.treesitter")
for lang, lib in pairs(treesitter) do
  vim.treesitter [lang] = lib
end
