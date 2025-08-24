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
  local start = new_pos[2]
  local end_ = start + #cword
  return start, end_
end

F.get_diagnostic_on_cursor = function()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local col = vim.api.nvim_win_get_cursor(0)[2]

  return vim.diagnostic.get(0, {
    lnum = line,
    col = col
  })
end

vim.lua.get_lsp_diagnostic_information = function()
  local diagnostic = F.get_diagnostic_on_cursor()[1]
  if diagnostic == nil then return end

  local data = diagnostic.user_data.lsp
  local message = data.message
  local source = data.source
  local output = string.format("Source = %s\n\"%s\"", source, message)
  local related = data.relatedInformation
  if related ~= nil then
    local messages = {}
    for _, row in ipairs(related) do
      table.insert(messages, row.message)
    end

    local relatedMessages = table.concat(messages, "\n")
    output = string.format("%s\n%s", output, relatedMessages)
  end
  vim.print(output)
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

F.replace_text_object_precise = function(motion, transform_fn)
  -- Save current register
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')

  -- Feed real keys like the user would type: vi(, vi", etc.
  local keys = 'vi' .. motion
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    'x', -- visual mode
    false
  )

  -- Exit visual mode so the marks are updated
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    'n',
    false
  )

  -- Wait for the visual selection to actually be made
  vim.defer_fn(function()
    local bufnr = 0

    local start_pos = vim.api.nvim_buf_get_mark(bufnr, '<')
    local end_pos = vim.api.nvim_buf_get_mark(bufnr, '>')

    -- If marks are still invalid, abort
    if start_pos[1] == 0 and start_pos[2] == 0 and end_pos[1] == 0 and end_pos[2] == 0 then
      vim.notify("No valid visual selection found", vim.log.levels.ERROR)
      return
    end

    -- Extract selected text
    local lines = vim.api.nvim_buf_get_text(
      bufnr,
      start_pos[1] - 1, start_pos[2],
      end_pos[1] - 1, end_pos[2] + 1,
      {}
    )

    local original_text = table.concat(lines, '\n')
    local new_text = transform_fn(original_text)

    if new_text then
      local new_lines = vim.split(new_text, '\n', { plain = true })

      vim.api.nvim_buf_set_text(
        bufnr,
        start_pos[1] - 1, start_pos[2],
        end_pos[1] - 1, end_pos[2] + 1,
        new_lines
      )

      vim.notify("Replaced text object.")
    else
      vim.notify("Transformation returned nil, nothing replaced.")
    end


    -- Restore register
    vim.fn.setreg('"', saved_reg, saved_regtype)
  end, 20) -- wait ~20ms before reading marks
end

F.surround_with_textobj = function(surr)
  local textobj = vim.fn.getcharstr()
  local left, right = unpack(surr)
  local do_surround = function(str)
    return left .. str .. right
  end

  F.replace_text_object_precise(textobj, do_surround)
end

F.surround_word = function(args)
  local left, right = unpack(args)
  local start, end_ = F.wildcard_position("<cword>")

  local str_node = vim.api.nvim_get_current_line():sub(start + 1, end_)
  vim.print(string.format("matched: %s", str_node))

  local result = left .. str_node .. right
  vim.print(result)

  F.replace_line(result, start, end_)
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
  local ith_arg = call.args[index]
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
