#!/usr/bin/lua

local M = {}

function M.verbose(params)
  local inspector = params.inspector or vim.inspect

  return setmetatable(params.tbl or {}, {
    ['__' .. params.metamethod] = function(t, k, v)
      vim.notify(inspector(t))
      return rawset(t, k, v)
    end

  })
end

function M.pairs(params)
  return setmetatable(params.tbl or {}, {
    __pairs = function(tbl)
      local function stateless_it(inner_table, k)
        return params.fn(next(inner_table, k))
      end

      return stateless_it, tbl, nil
    end
  })
end

return M
