local F = {}

function F.put_text(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, '\n'), '\n')
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

function F.apply(lambda, ...)
  local params = { params }
  local count = params.n
  local offest = count - 1
  local packed = params[count]

  if type(packed) == "table" then
    params[count] = nil
    for index, item in pairs(packed) do
      if type(index) == "number" then
        count = offest + index
        params[count] = item
      end
    end
  end

  return lambda(unpack(params, 1, count))
end

function F.partial(lambda, ...)
  local curried = { ... }
  local offset = #curried
  return function(...)
    local params = { unpack(curried, 1, offset) }
    params[offset + 1] = { ... }
    return apply(lambda, unpack(params, 1, offset + 1))
  end
end

function F.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function F.fg(name)
  ---@type {foreground?:number}?
  local hlgrp = vim.api.nvim_get_hl(0, { name = name })
  return hlgrp and hlgrp.foreground
end

function F.split(str, sep)
  local regex = nil
  if sep == nil or sep == '' then
    regex = '.'
  else
    regex = "([^" .. sep .. "]+)"
  end

  return str:gmatch(regex)
end

function F.map(table_map)
  for shortcut, described_action in pairs(table_map) do
    local desc, modes, action, opts = unpack(described_action)
    opts = opts or {}
    for mode in vim.lua.split(modes, '') do
      vim.keymap.set(mode, shortcut, action, { desc = desc, expr = opts['expr'], silent = opts['silent'] })
    end
  end
end

function F.loader(fn, tbl)
  return {
    load = function() fn(tbl) end
  }
end

return F
