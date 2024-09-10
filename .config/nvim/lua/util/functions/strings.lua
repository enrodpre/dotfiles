#!/usr/bin/lua

local M = {}

M.check_all_lowercase = function(str)
  if str == "" then
    return false
  end

  return str == string.lower(str)
end

M.check_first_uppercase = function(str)
  if str == "" then
    return false
  end

  local first = string.sub(str, 1, 1)
  return first == string.upper(first)
end

M.trim = function(s)
  return s:gsub("[\n]", "")
end

return M
