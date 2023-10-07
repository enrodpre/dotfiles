local lfs = require("lfs")

local readers = {}

local is_excluded = function(file, excluded)
  for _, v in ipairs(excluded) do
    if string.find(file, v) then
      return true
    end
  end
end

function readers.read_files_from_folder(path, excluded)

  local excluded = excluded or {}
  table.insert(excluded, "init")
  
  local loaded_files = {}

  for name in lfs.dir(path) do
    if not is_excluded(file, excluded) then
      loaded_files[filename] = require(path .. "." .. filename)
    end
  end
  files:close()

  return loaded_files
end

function readers.read_files_from_current_folder(excluded)
	return readers.read_files_from_folder(lfs.currentdir())
end


return read_files_from_folder
