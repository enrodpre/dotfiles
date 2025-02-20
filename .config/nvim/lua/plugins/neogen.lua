local simple = function(prompt, results)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  pickers
    .new({}, {
      prompt_title = prompt,
      finder = finders.new_table { results = results, },
    })
    :find()
end

local choose_neogen = function()
  return simple("Choose neogen element", require("neogen").match_commands())
end

return {
  "danymat/neogen",
  dependencies = { "nvim-telescope/telescope.nvim", },
  keys = {
    {
      ",d",
      function()
        choose_neogen()
      end,
      desc = "[A]pply [D]oc Generation",
    },
  },
  config = true,
}
