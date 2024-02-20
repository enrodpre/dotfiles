#!/usr/bin/lua

local lyaml = require("lyaml")
local M = {}

local filepath = os.getenv("XDG_CONFIG_HOME") .. "/" .. "config.yaml"

local function read_file(path)
	local file = io.open(path, "rb") -- r read mode and b binary mode
	if not file then return nil end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content
end

function M.read_config(path)
	local fileContent = read_file(filepath);
	return lyaml.load(fileContent)
end
