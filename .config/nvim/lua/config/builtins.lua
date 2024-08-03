#!/usr/bin/lua

local function parse_and_init(tbl_path)
  local steps = vim.split(tbl_path, ".", { plain = true })
  local ref = _G

  for _, step in ipairs(steps) do
    ref[step] = ref[step] or {}
    ref = ref[step]
  end

  return ref
end

local M = {
  ["util.functions"] = "vim.lua",
  ["util.metatables"] = "vim.lua.metatables",
  ["util.module"] = "_G",
}

for module_name, target in pairs(M) do
  local ok, _module = pcall(require, module_name)

  if not ok then
    vim.print("Error loading module " .. module_name)
  end

  local container = parse_and_init(target)

  for name, value in pairs(_module) do
    container[name] = value
  end
end
