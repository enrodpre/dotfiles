#!/usr/bin/lua

local M = {}

function M.verbose(params)
   local inspector = params.inspector or vim.inspect

   return setmetatable(params.tbl or {}, {
      ["__" .. params.metamethod] = function(t, k, v)
         vim.notify(inspector(t))
         return rawset(t, k, v)
      end,

   })
end

function M.pairs(params)
   return setmetatable(params.tbl or {}, {
      __pairs = function(tbl)
         local function stateless_it(inner_table, k)
            return params.fn(next(inner_table, k))
         end

         return stateless_it, tbl, nil
      end,
   })
end

function M.default(value)
   local new = {}

   local function create(key)
      value = value or {}
      new [key] = value
      return value
   end

   return setmetatable(new, {
      __index = create,
   })
end

return M
