vim.lua = vim.lua or {}
local F = vim.lua

F.wildcard_position = function(w)
  w = w or "<cword>"

  local cur_pos = vim.api.nvim_win_get_cursor(0)
  local cword = vim.fn.expand(w)
  -- jump to beginning of word under cursor
  -- b: backward
  -- c: accept match right under cursor
  vim.fn.search(cword, "bc")
  local new_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, cur_pos)
  -- zero-indexed, add 1 as example indicates 1 indexing
  local start = new_pos [2]
  local end_ = start + #cword
  return start, end_
end


F.wildcard_position_rel = function(w)
  local start, end_ = F.wildcard_position(w)
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col - start, end_ - col
end

F.replace_line = function(str, start, end_)
  if not str then return end

  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, start)
  local after = end_ and line:sub((end_) + 1) or ""

  vim.api.nvim_set_current_line(before .. str .. after)
end


F.search = function(pattern, flags)
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.fn.search(pattern, flags)
  local result = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, cursor)
  return result
end

F.line_match = function(pattern, init)
  init = init or 1
  local line = vim.api.nvim_get_current_line()
  local surrounded = line:match(pattern, init)
  local start, end_ = line:find(surrounded, init)
  if not start then return nil end
  assert(surrounded == line:sub(start, end_))
  return surrounded, start, end_
end


F.surround_node = function(args)
  local left, right = unpack(args)
  local start, end_ = F.wildcard_position("<cWORD>")

  local str_node = vim.api.nvim_get_current_line():sub(start, end_)
  vim.print(string.format("matched: %s", str_node))

  local result = left .. str_node .. right

  F.replace_line(result, start, end_)
end

F.node_name = function(node)
  vim.print(vim.treesitter.get_node_text(node, 0))
end

F.replace_node = function(before, after)
  local _, start, _, end_ = before:range()
  local after_text = vim.treesitter.get_node_text(after, 0)
  F.replace_line(after_text, start, end_)
end


F.unfold_template_node = function(args)
  local index = args.index or 1
  local template_node = args.node or vim.treesitter.get_node()
  if not template_node then return end

  local parameter = vim.treesitter.cpp.get_template_parameter_node { node = template_node, index = index, }
  local node = vim.treesitter.cpp.get_full_type_node(template_node)
  if not node then return end

  F.replace_node(node, parameter)
end

F.unfold_call_node = function(args)
  local index = args.index or 1
  local cword = args.node or vim.treesitter.get_node()
  if not cword then return end

  local call = vim.treesitter.cpp.Call.new(cword)
  local top_node = call.top_node
  local ith_arg = call.args [index]
  F.replace_node(top_node, ith_arg)
end

F.unfold_node = function(args)
  local node = args.node or vim.treesitter.get_node()
  if not node then return end

  if vim.treesitter.cpp.is_type(node) then
    F.unfold_template_node { node = node, index = 1, }
  elseif vim.treesitter.cpp.is_call(node) then
    F.unfold_call_node { node = node, index = 1, }
  else
    vim.print("Unrecognized node")
  end
end
