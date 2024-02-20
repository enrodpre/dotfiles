#!/usr/bin/lua

local lyaml = require("lyaml")
local M = {}

local function read_file(path)
	local file = io.open(path, "rb") -- r read mode and b binary mode
	if not file then return nil end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content
end

function M.read_config(path) return lyaml.load(read_file(path)) end

function M.write_config(path, config)
	-- pass
end

return M
