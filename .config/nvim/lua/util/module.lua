local M = {}

---@param mod string|fun()
---@return table?
function M.safereq(mod)
  -- using xpcall instead of pcall for catching the stacktrace
  local success, result = xpcall(require, debug.traceback, mod)
  if success then
    return result
  else
    -- local msg = debug.traceback("Error requiring " .. module .. "\n" .. result)
    local msg = "Error requiring " .. tostring(mod) .. "\n" .. result
    vim.schedule(function()
      -- vim.notify(msg, { title = 'Error loading module' })
      msg, _ = msg:gsub("[\t]", "        ")
      vim.api.nvim_err_writeln(msg)
    end)
    return nil
  end
end

---@param mod string
---@return table
function M.lazyreq(mod)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(mod)[k](...)
      end
    end,
  })
end

return M
