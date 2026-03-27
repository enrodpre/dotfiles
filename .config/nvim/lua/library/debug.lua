local T = {}

-- Helper function to serialize a table for preview
local function serialize_table(tbl)
  local lines = {}

  for k, v in pairs(tbl) do
    table.insert(lines, string.format("%s = %s", k, type(v)))
  end

  return lines
end

T.fuzzy_table = function(tbl, name)
  if not tbl or not next(tbl) then
    vim.print("Not a valid object")
    return
  end

  name = name or "Table Explorer"

  -- Convert table to entries for fzf
  local entries = {}
  local key_map = {}

  for k, v in pairs(tbl) do
    local type_str = type(v)
    if type_str == "table" then
      type_str = "table [" .. vim.tbl_count(v) .. " items]"
    end
    local entry = string.format("%-30s %s", tostring(k), type_str)
    table.insert(entries, entry)
    key_map[entry] = k
  end

  ---@param entry string
  local function get_key_from_entry(entry)
    local chunks = vim.fn.split(entry, " =")
    return chunks[1]
  end

  local fzf = require("fzf-lua")

  fzf.fzf_exec(serialize_table(tbl), {
    prompt = name .. "> ",
    preview = function(selected)
      if not selected or #selected == 0 then
        return ""
      end

      local entry = selected[1]
      local key = get_key_from_entry(entry)
      local value = tbl[key]

      if type(value) == "table" then
        local preview_lines = serialize_table(value)
        return table.concat(preview_lines, "\n")
      else
        return tostring(value)
      end
    end,
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        local entry = selected[1]
        local key = key_map[entry]
        local value = tbl[key]

        if type(value) == "table" then
          -- Recursively explore the nested table
          T.fuzzy_table(value, name .. " > " .. tostring(key))
        else
          print(tostring(key) .. " = " .. tostring(value))
        end
      end,
    },
  })
end

T.setup = function()
  -- Toggle the profiler
  -- Snacks.toggle.profiler():map("<leader>pp")
  -- Toggle the profiler highlights
  -- Snacks.toggle.profiler_highlights():map("<leader>ph")
end
return T
