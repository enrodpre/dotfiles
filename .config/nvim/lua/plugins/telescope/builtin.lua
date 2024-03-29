local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config")
local themes = require "telescope.themes"
local func = require("util.functions")
local get_selected_text = func.get_selected_text
local trim = func.trim
local dump = require("util.debug").dump

local F = {}
function F.inspect()
   local selected = get_selected_text()
   if vim.api.nvim_list_uis() == 0 then
      selected = vim.fn.input {
         prompt = "> ",
         default = selected,
      }
   end
   local ob = {
      "asdb",
      "asd",
      "as1b",
      selected,
      -- {
      --    "asd",
      -- },
   }
   pickers.new({}, {
      prompt_title = "Inspect object",
      finder = finders.new_table { results = ob, },
      -- sorter = conf.generic_sorter()

   }):find()
end

return F
