#!/usr/bin/lua

---@type Config
local config = require("config.defaults")

local M = setmetatable({}, {
  __index = function(_, k)
    return config[k]
  end,
})

function M.add_plugin(spec) end

---@param idx string
function M.get(idx)
  local tbl_from_idx = require("util.functions").tbl_from_idx
  local ref, key = tbl_from_idx(config, idx)
  if ref then
    return ref[key]
  end
end

function M.set(idx, value)
  local tbl_from_idx = require("util.functions").tbl_from_idx
  local ref, key = tbl_from_idx(config, idx)
  if ref and key then
    ref[key] = value
  end
end

---@param group string
function M.list_icons(group)
  for _, source in ipairs(config.icons) do
    local ok, icons = pcall(source().list, group)
    if ok then
      return icons
    end
  end
end

---@param group string
---@param elem string
function M.get_icon(group, elem)
  for _, source in ipairs(config.icons) do
    local ok, icon = pcall(source().get, group, elem)
    if ok then
      return icon
    end
  end
end

M.icons = setmetatable({}, {
  __index = function(_, grp)
    local group = grp
    return setmetatable({}, {
      __index = function(_, elem)
        return vim.schedule(function()
          M.get_icon(group, elem)
        end)
      end,
      __pairs = function()
        return function() end
      end,
    })
  end,
})

function M.save() end

local function prepare_lazy()
  config.lazy = config.lazy or {}
  -- stylua: ignore
  config.lazy.install = config.lazy.install or {missing=true, colorscheme=config.colorscheme}
end

function M.init()
  vim.config = M
  prepare_lazy()

  local scripts = config.scripts

  if scripts then
    local sorter = function(t, a, b)
      return t[a].priority >= t[b].priority
    end

    for script, opts in require("util.functions").spairs(scripts, sorter) do
      if opts.enabled then
        -- vim.schedule(function()
        pcall(require, "config." .. script)
        -- end)
      end
    end
  end
  if config.colorscheme then
    -- vim.schedule(function()
    vim.cmd([[ colorscheme ]] .. config.colorscheme[1] or config.colorscheme)
    -- end)
  end

  -- require("lazy.core.config").plugins["config"] = M
end

function M.setup() end

return M
