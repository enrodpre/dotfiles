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

-- local lfs = require("lfs")

function F.read_files_from_folder(path, excluded_files)
  local is_excluded = function(file)
    for _, v in ipairs(excluded_files) do
      if string.find(file, v) then
        return true
      end
    end
  end

  local excluded = excluded_files or {}
  table.insert(excluded_files, "init")

  local loaded_files = {}

  for name in lfs.dir(path) do
    if not is_excluded(file) then
      loaded_files[name] = require(path .. "." .. filename)
    end
  end

  return loaded_files
end

local external_files_functions = vim.split(vim.fn.glob('~/.config/nvim/lua/util/functions/*.lua'), '\n')

for _, file in pairs(external_files_functions) do
  local filename = vim.fn.fnamemodify(file, ':t:r')
  if filename ~= 'init' then
    local func = require('util.functions.' .. filename)
    F[filename] = func
  end
end

return F
