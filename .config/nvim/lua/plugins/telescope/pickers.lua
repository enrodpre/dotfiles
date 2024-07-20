local on_require = vim.lua.lazyreq.on_exported_call

-- local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'

local F = {}
function F.simple(prompt, results)
  pickers
    .new({}, {
      prompt_title = prompt,
      finder = finders.new_table { results = results },
    })
    :find()
end

function F.choose_neogen()
  return F.simple('Choose neogen element', require('neogen').match_commands())
end

return F
