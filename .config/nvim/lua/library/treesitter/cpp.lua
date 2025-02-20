local identifiers = {
  qualified = "qualified_identifier",
  template = { type = "template_type", args = "template_argument_list", },
  type = "type_identifier",
  call = { type = "call_expression", args = "argument_list", },
  primitive = "primitive_type",
}

F = {}

F.next_parent_node = function(args)
  if not args.type then return end
  local type = args.type
  local node = args.node or vim.treesitter.get_node()
  if not node then return end


  while node do
    if node:type() == type then return node end
    node = node:parent()
  end
end

F.parent_if = function(args)
  local node = args.node or vim.treesitter.get_node()
  if not node then error() end

  if not args.types then return node end
  local types = args.types
  while vim.list_contains(types, node:type()) do
    node = node:parent()
  end
  return node
end

F.Call = {}
function F.Call.new(node)
  local top_node = F.next_parent_node { node = node, type = identifiers.call.type, }
  if not top_node then error("Not a call") end

  local call = {
    root = top_node,
    func = top_node:field("function") [1],
    args = top_node:field("arguments") [1],
  }

  return call
end

F.next_child_node = function(args)
  if not args.type then return end
  local node = args.node or vim.treesitter.get_node()
  if not node then return end

  local function recursive_find(curr)
    if curr:type() == args.type then return curr end
    if curr:child_count() == 0 then return end

    for child in curr:iter_children() do
      local res = recursive_find(child)
      if res then return res end
    end
  end

  return recursive_find(node)
end

F.get_full_type_node = function(node)
  node = node or vim.treesitter.get_node()
  if not node then return end

  if node:type() ~= identifiers.type then
    vim.print("Place cursor on top type")
    return
  end

  if node:parent():type() == identifiers.template.type then
    node = node:parent()
    if node:parent():type() == identifiers.qualified then
      node = node:parent()
    end
  end

  return node
end

F.get_template_parameter_node = function(args)
  local node = args.node or vim.treesitter.get_node()
  if not node then return end
  local index = args.index or 1

  if node:parent():type() ~= identifiers.template.type then
    vim.print("Place cursor on template type")
    return
  end

  local arguments = node:next_sibling()
  if not arguments then return end
  assert(arguments:type() == identifiers.template.args)

  if index > arguments:child_count() then
    vim.print("Index out of bounds")
    return
  end

  return arguments:child(index)
end

F.get_full_call_node = function(node)
  return F.next_parent_node { node = node, type = identifiers.call.type, }
end
F.get_call_argument_node = function(args)
  local node = args.node or vim.treesitter.get_node()
  if not node then return end
  local index = args.index or 1

  local call_node = F.get_full_call_node(node)
  local arguments = call_node:field("arguments") [1]
  return arguments:child(index)
end

F.is_type = function(node)
  node = node or vim.treesitter.get_node()
  return string.match(node:type(), "type") ~= nil
end

F.is_call = function(node)
  node = node or vim.treesitter.get_node()
  return F.Call.new(node) ~= nil
end

return F
