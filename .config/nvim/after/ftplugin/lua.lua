-- Function to format Lua tables by breaking on { and } characters
local function format_lua_table()
  -- Get current line number and content
  local line_num = vim.api.nvim_win_get_cursor(0) [1]
  local line_content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num,
    false) [1]


  if not line_content or line_content == "" then
    return
  end

  -- Get the indentation of the current line
  local indent = line_content:match("^(%s*)")

  -- Process the line to add breaks around { and }
  local result_lines = {}
  local current_line = ""
  local brace_depth = 0

  for i = 1, #line_content do
    local char = line_content:sub(i, i)

    if char == "{" then
      -- Add the opening brace on its own line (or current line if it's the start)
      if current_line:match("%S") then
        table.insert(result_lines, current_line)
        current_line = indent .. string.rep("  ", brace_depth) .. "{"
      else
        current_line = current_line .. "{"
      end
      brace_depth = brace_depth + 1
      table.insert(result_lines, current_line)
      current_line = indent .. string.rep("  ", brace_depth)
    elseif char == "}" then
      -- Close current line if it has content
      if current_line:match("%S") then
        table.insert(result_lines, current_line)
      end
      brace_depth = math.max(0, brace_depth - 1)
      current_line = indent .. string.rep("  ", brace_depth) .. "}"
      table.insert(result_lines, current_line)
      current_line = indent .. string.rep("  ", brace_depth)
      -- elseif char == "," then
      --   current_line = current_line .. char
      --   -- Add line break after comma if we're inside braces
      --   if brace_depth > 0 then
      --     table.insert(result_lines, current_line)
      --     current_line = indent .. string.rep("  ", brace_depth)
      --   end
    else
      current_line = current_line .. char
    end
  end

  -- Add any remaining content
  if current_line:match("%S") then
    table.insert(result_lines, current_line)
  end

  -- Remove empty lines and trim whitespace
  local cleaned_lines = {}
  for _, line in ipairs(result_lines) do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed ~= "" then
      -- Preserve proper indentation
      local proper_indent = indent ..
        string.rep("  ",
          math.max(0,
            select(2, line:gsub("{", "")) - select(2, line:gsub("}", ""))))
      table.insert(cleaned_lines, line)
    end
  end

  -- Replace the current line with the formatted lines
  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, cleaned_lines)

  -- Position cursor at the start of the formatted block
  vim.api.nvim_win_set_cursor(0, { line_num, 0, })
end

-- Simpler version that just breaks on { and } without fancy indentation
local function simple_format_lua_table()
  local line_num = vim.api.nvim_win_get_cursor(0) [1]
  local line_content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num,
    false) [1]

  if not line_content or line_content == "" then
    return
  end

  -- Get base indentation
  local indent = line_content:match("^(%s*)")

  -- Split on { and } while preserving them
  local parts = {}
  local current = ""

  for i = 1, #line_content do
    local char = line_content:sub(i, i)
    if char == "{" or char == "}" then
      if current:match("%S") then
        table.insert(parts, current)
        current = ""
      end
      table.insert(parts, char)
    else
      current = current .. char
    end
  end

  if current:match("%S") then
    table.insert(parts, current)
  end

  -- Create new lines with proper formatting
  local new_lines = {}
  local depth = 0

  for _, part in ipairs(parts) do
    if part == "{" then
      table.insert(new_lines, indent .. string.rep("  ", depth) .. part)
      depth = depth + 1
    elseif part == "}" then
      depth = math.max(0, depth - 1)
      table.insert(new_lines, indent .. string.rep("  ", depth) .. part)
    else
      local trimmed = part:match("^%s*(.-)%s*$")
      if trimmed ~= "" then
        table.insert(new_lines, indent .. string.rep("  ", depth) .. trimmed)
      end
    end
  end

  -- Replace the line
  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, new_lines)
end

-- Create a command to call the function
vim.api.nvim_create_user_command("LuaTableSimple",       format_lua_table,        {})
vim.api.nvim_create_user_command("FormatLuaTableSimple", simple_format_lua_table,
                                                                                    {})

-- Optional: Create a keybinding
-- vim.keymap.set('n', '<leader>ft', simple_format_lua_table, { desc = 'Format Lua table on current line' })
