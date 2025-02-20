vim.print(moduledir)

local modules = { "cpp", }
M = {}

for _, module in ipairs(modules) do
  -- vim.print(module)
  local functions = require("library.treesitter." .. module)

  M [module] = functions
end

return M
