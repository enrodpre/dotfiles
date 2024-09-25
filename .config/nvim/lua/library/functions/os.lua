#!/usr/bin/lua

local M = {}

M.exists = function(path)
  local stat = require("posix.sys.stat")
  vim.notify(path)
  local exists = stat.stat(path)
  vim.notify(exists)
  return exists
end
M.file_ext = function(filename)
  return vim.fn.fnamemodify(filename, ":e")
end

return M
