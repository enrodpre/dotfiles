#!/usr/bin/lua
local F = {}

function F.run_tests()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local current_project_path = os.getenv "CURRENT_PROJECT"

  local split_string = function(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
      table.insert(t, str)
    end
    return t
  end

  local get_config_from_file = function(relative_path)
    local filepath = current_project_path .. relative_path
    local result = {}

    for line in io.lines(filepath) do
      table.insert(result, split_string(line, "::"))
    end
    return result
  end

  local create_script_on_root_directory = function(selection)
    local result = {}
    table.insert(result, "pushd " .. current_project_path)
    table.insert(result, selection.value[2] .. " | tee testfailedall")
    table.insert(result, "echo " .. selection.value[3] .. " > testlastproject")
    table.insert(result, "popd")
    return result
  end

  local config = get_config_from_file "/test/test.config"

  pickers
    .new(opts, {
      prompt_title = " tests ",
      finder = finders.new_table {
        results = config,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()

          local script_table = create_script_on_root_directory(selection)
          local script = table.concat(script_table, ";")

          print(vim.inspect(script_table))
          os.execute("echo " .. script .. " > debug")
          os.execute(script)
        end)

        return true
      end,
    })
    :find()
end

return F
