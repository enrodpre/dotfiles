#!/usr/bin/lua

local M = {}

M.constructor = function()
  local strings = vim.lua.fn.strings
  local editor = vim.lua.fn.editor

  local classname = vim.fn.expand("<cword>")
  local topline = vim.api.nvim_get_current_line()

  local gather_members = function()
    local check_red_flags = function(tbl)
      local red_flags = { "}", "(", ")", classname }
      for _, token in ipairs(tbl) do
        if vim.list_contains(red_flags, token) then
          return true
        end
      end
    end

    if not classname or not strings.check_first_uppercase(classname) then
      vim.print("Go over the class name and try again")
      return
    end

    local members = {}
    if string.match(topline, "struct") or string.match(topline, "class") then
      local start = vim.fn.line(".")
      local last_line = vim.fn.line("$")
      local ignore_lines_with_tokens = { "public", "protected", "private" }

      for i = start + 1, last_line do
        local current_line = vim.fn.getline(i)
        current_line = strings.trim(current_line)

        if #current_line < 1 then
          return members, i
        end

        -- Check if we have to ignore the line
        for _, ignorable in ipairs(ignore_lines_with_tokens) do
           if current_line:match(ignorable) then goto continue end
        end

        local trim_semicolon = current_line:gsub(";", "")

        local tokens = vim.split(trim_semicolon, " ", { trimempty = true })

        if check_red_flags(tokens) then
          return members, i
        end

        table.insert(members, tokens)

         ::continue::
      end
    end
  end

  local vars, target_line = gather_members()
  vars = vars or {}

  local varnames = {}
  for _, member in ipairs(vars) do
    local variable = member[#member]

    if not strings.check_all_lowercase(variable) then
      vim.print("I might be wrong, but I think %s is not a variable member")
      return false
    end

    table.insert(varnames, variable)
  end

  local format_varname = function(varname)
    return string.format("%s(%s)", varname, varname)
  end

  -- Var names are for the initializations
  local formatted_varnames = vim.tbl_map(format_varname, varnames)
  local joined_varnames = table.concat(formatted_varnames, ",")

  -- Variables with its types is for the declaration of the constructor
  local format_var = function(elem) return table.concat(elem, " ") end
  local joined_vars = vim.tbl_map(format_var, vars)
  local join_formatted_vars = table.concat(joined_vars, ",")

  local result = string.format("%s(%s):%s {}", classname, join_formatted_vars, joined_varnames)

  editor.put_line(target_line - 1, "")
  editor.put_line(target_line, result)
end

return M