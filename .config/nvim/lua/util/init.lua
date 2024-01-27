local F = {}
local namemodify = vim.fn.fnamemodify


function F.tbl_flatten(tbl, depth)
  local result = {} -- F.notifier_table()

  local function flatten(t, d)
    for k, v in pairs(t) do
      if type(v) == 'table' and depth > 0 then
        flatten(v, d - 1)
      else
        result[k] = v
      end
    end
  end

  flatten(tbl, depth)

  return result
end

function F.iter_to_table_filtered(it, filter_func)
  local tbl = {}
  for v in it do
    if filter_func and filter_func(v) then
      table.insert(tbl, v)
    end
  end
  return tbl
end

function F.get_module_info()
  local info = debug.getinfo(1, 'S')
  local module_directory = string.match(info.source, '^@(.*)/')
  local module_filename = string.match(info.source, '/([^/]*)$')
  local module_name = vim.fn.expand('%:t:r')

  return module_directory, module_filename, module_name
end

return F
