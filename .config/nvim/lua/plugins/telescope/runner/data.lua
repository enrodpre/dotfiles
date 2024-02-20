local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config")
local themes = require "telescope.themes"
local func = require("util.functions")
local get_selected_text = func.get_selected_text
local trim = func.trim
local dump = require("util.debug").dump

local F = {}
local ob = {
   "asdb",
   "asd",
   "as1b",
   {
      "asd",
   },
}
function F.inspect()
   local selected = get_selected_text()
   print(selected)
   local obj_to_inspect = vim.fn.input(selected)
   pickers.new({}, {
      prompt_title = "Inspect object",
      finder = finders.new_table { results = ob, },
      -- sorter = conf.generic_sorter()

   }):find()
end

return F
