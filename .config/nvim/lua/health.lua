local M = {}

local start = vim.health.start
local ok = vim.health.ok
local warn = vim.health.warn
local error = vim.health.error

function M.check()
   start("util")

   if not vim.lua then
      warn("vim.lua does not exist")
   else
      if not vim.lua.fn then
         warn("vim.lua.fn does not exist")
      end
      if not vim.lua.metatables then
         warn("vim.lua.metatables does not exist")
      end
      if not vim.lua.lazyreq then
         warn("vim.lua.lazyreq does not exist")
      end
   end
end

return M
