local autocmds = {}
local load_module = require('utils').load_module
local create_cmd, create_group = vim.api.nvim_create_autocmd, vim.api.nvim_create_augroup
local unpack = unpack

local function create_autocmd(t)
  local event, callback, pattern, desc, buffer, once, group =
      t.event or nil,
      t.callback or function() end,
      t.pattern or nil,
      t.desc or nil,
      t.buffer or nil,
      t.once or nil,
      t.group or nil

  create_cmd({ event, callback, pattern, desc, buffer, once, group })
end

local loader = {}

function loader.load()
  local module_name = 'autocmds'
  local loaded_files = load_module(module_name)
  for group, cmds in pairs(loaded_files) do
    local idgp = create_group(group, {})

    for _, cmd in ipairs(cmds) do
      create_autocmd({
        group = idgp,
        unpack(cmd),
      })

      autocmds.count = autocmds.count + 1
    end
  end
end

return loader
