local M = {}
_G.Gdb = M

M.breakpoints = {}


local function write_breakpoints_file()
  local lines = { 'set breakpoint pending on' }

  for bp, _ in pairs(M.breakpoints) do
    table.insert(lines, 'break ' .. bp)
  end

  -- Write to file
  local f = io.open('gdb/breakpoints.gdb', 'w')
  if f then
    for _, line in ipairs(lines) do
      f:write(line .. '\n')
    end
    f:close()
  end
end


function M.start()
  vim.cmd("packadd termdebug")
  vim.cmd("Termdebug")
end

function M.toggle_gdb_breakpoint()
  -- local file = vim.fn.expand('%:p')
  local line = vim.fn.line('.')
  local key = vim.fn.expand('%:t') .. ':' .. line -- Use relative path for GDB

  if M.breakpoints[key] then
    -- Remove breakpoint
    M.breakpoints[key] = nil
    print('Removed breakpoint at ' .. key)
    -- Optional: Add sign removal
    vim.fn.sign_unplace('gdb_bp', { buffer = vim.fn.bufnr('%'), id = line })
  else
    -- Add breakpoint
    M.breakpoints[key] = true
    print('Added breakpoint at ' .. key)
    -- Optional: Add sign for visual feedback
    vim.fn.sign_place(line, 'gdb_bp', 'GdbBreakpoint', vim.fn.bufnr('%'), { lnum = line })
  end

  write_breakpoints_file()
end

function M.clear_all_breakpoints()
  M.breakpoints = {}
  write_breakpoints_file()
  -- Clear all signs
  vim.fn.sign_unplace('gdb_bp')
  print('Cleared all breakpoints')
end

function M.list_breakpoints()
  if next(M.breakpoints) == nil then
    print('No breakpoints set')
    return
  end

  print('Current breakpoints:')
  for bp, _ in pairs(M.breakpoints) do
    print('  ' .. bp)
  end
end

-- Define sign for visual feedback
vim.fn.sign_define('GdbBreakpoint', {
  text = '●',
  texthl = 'Error',
  linehl = '',
  numhl = ''
})


return M
