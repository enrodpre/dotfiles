#!/usr/bin/lua
vim.lua = vim.lua or {}

local M = {
  ["library.functions"] = "fn",
  ["library.metatables"] = "metatables",
  ["library.lazy_require"] = "lazyreq",
  ["library.editor"] = "editor",
}

for module_name, target in pairs(M) do
  local ok, _module = pcall(require, module_name)

  if not ok then
    vim.print("Error loading module " .. module_name)
  end

  vim.lua[target] = vim.lua[target] or {}

  for name, value in pairs(_module) do
    vim.lua[target][name] = value
  end
end

_G["lazyreq"] = vim.lua.lazyreq.on_exported_call
