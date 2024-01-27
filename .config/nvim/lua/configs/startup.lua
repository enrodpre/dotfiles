#!/usr/bin/lua

local open = io.open

local function read_file(path)
	local file = open(path, "rb") -- r read mode and b binary mode
	if not file then return nil end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content
end

local filepath = os.getenv("XDG_CONFIG_HOME") .. "/" .. "config.yaml"
local fileContent = read_file(filepath);

return require('lyaml').load(fileContent)
