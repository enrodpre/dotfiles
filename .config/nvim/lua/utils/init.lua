#/usr/bin/lua

local F = {}
local namemodify = vim.fn.fnamemodify

function F.notifier_table(inspector)
  inspector = inspector or vim.inspect

  local function newindex(t, k, v)
    vim.notify(inspector(t))
    return rawset(t, k, v)
  end

  return setmetatable({}, {
    __newindex = newindex
  })
end

function F.tbl_flatten(t, depth)
  local result = {} -- F.notifier_table()

  local function flatten(t, depth)
    for k, v in pairs(t) do
      if type(v) == 'table' and depth > 0 then
        flatten(v, depth - 1)
      else
        result[k] = v
      end
    end
  end

  flatten(t, depth)

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

local file_filterer = function(filename)
  local is_lua_module = "lua" == namemodify(filename, ':e')
  local is_this_file = 'init.lua' == namemodify(filename, '%:t')
  return is_lua_module and not is_this_file and filename ~= 'profiler.lua'
end

local function get_folder_content_filenames(directory)
  local pfile = io.popen('ls -A "' .. directory .. '"')
  if pfile then
    return F.iter_to_table_filtered(pfile:lines(), file_filterer)
  end
end

local function get_module_abs_path(module_name)
  local file_abs_path = debug.getinfo(1, "S").source:sub(2)
  return namemodify(file_abs_path, ":h")
end

local function load_files_from_folder(module_name)
  local abs_path = get_module_abs_path(module_name)
  local filenames = get_folder_content_filenames(abs_path)

  local result = {}
  for _, filename in pairs(filenames) do
    local name = namemodify(filename, ':t:r')
    local lua_name = module_name .. '.' .. name
    local ok, loaded_file = pcall(require, lua_name)
    if ok then
      result[name] = loaded_file
    end
  end

  return result
end

function F.load_module(module_name)
  local loaded_files = load_files_from_folder(module_name)
  return F.tbl_flatten(loaded_files, 1)
end

local module_name = 'utils'
local extern_F = F.load_module(module_name)
local F = vim.tbl_extend("force", extern_F, F)

return F
