local functions = {}

function functions.split(str, del)
    local result = {};
    for match in (str..del):gmatch("(.-)"..del) do
        table.insert(result, match);
    end
    return result;
end

function functions.execute_py(filename)
  if string.sub(filename, -2) ~= 'py' then
    print("The file isn't a valid python file")
    return nil
  end
  local command = '. $HOME/.config/custom/funcs && python3 ' .. filename .. ' 2>&1 | python_error_line '
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local split_string = functions.split(result, ':')
  local file, line = split_string[1], split_string[2]
  if file ~= vim.fn.expand('%:p') then
    vim.api.nvim_command(string.format("[[:open(%s)]]", file))
  end
  vim.api.nvim_win_set_cursor(0, {tonumber(line), 0})
end

function functions.execute_bash(command_str)
  local handle = io.popen(command_str)
  local result = handle:read("*all")
  handle:close()
  return result
end

function functions.array_contains(arr, val)
  for _, elem in ipairs(arr) do
    if elem == val then
      return true
    end
  end

  return false
end

return functions
