local submodules = require("functions").get_submodules("library")
for _, submodule in ipairs(submodules) do
  local ok, loaded = pcall(require, submodule)
  if ok and type(loaded) == "table" and loaded["setup"] then
    loaded.setup()
  end
end
