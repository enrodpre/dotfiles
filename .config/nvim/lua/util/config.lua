#!/usr/bin/lua

local parse_composed_key = require("util.functions").tbl_from_idx

---@alias Path string

---@class Change
---@field idx Path
---@field before string
---@field after string
local Change = {}
function Change:new(idx, before, after)
  self.idx = idx
  self.before = before
  self.after = after
end

---@class Config
---@field dir string
---@field file string
---@field data table<any,any>
---@field history Change[]
local Config = {}

function Config:new(opts)
  self.dir = opts.dir or vim.fn.stdpath("config") .. "/config"
  self.file = opts.file or "defaults"
  self.data = {}
  self.history = {}
end

function Config:load(data)
  self.data = data
end

---@param idx Path
function Config:get(idx)
  local ref, key = parse_composed_key(self.data, idx)
  if ref then
    return ref[key]
  end
end

---@param idx Path
---@param value any
function Config:set(idx, value)
  local ref, key = parse_composed_key(self.data, idx)
  if ref and key then
    local before = ref[key]
    ref[key] = value
    local after = ref[key]
    local change = Change:new(key, before, after)
    table.insert(self.history, change)
  end
end

function Config:save() end
