local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config")
local themes = require "telescope.themes"
local func = require('util.functions')
local get_selected = func.get_selected
local trim = func.trim
local dump = require('util.debug').dump

local F = {}

function F.inspect()
	local obj = get_selected { as = "obj" }
	pickers.new({}, {
		prompt_title = "Inspect object",
		finder = finders.new_table { results = obj },
		sorter = conf.generic_sorter()

	}):find()
end

return F
