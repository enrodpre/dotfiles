#!/usr/bin/lua

local M = {}

M.put_line = function(number, payload)
  payload = payload or ""

  vim.api.nvim_buf_set_lines(0, number, number, false, { payload })
end

---@alias position
---| {row: number, col: number}
local position = {
  __call = function(row, col)
    return row, col
  end,
  first = function()
    return 1, 1
  end,
  current = function()
    return vim.api.nvim_win_get_cursor(0)
  end,
  last = function()
    local buf = vim.api.nvim_win_get_buf(0)
    local lines = vim.api.nvim_buf_get_lines(buf, 2, 1, false)
    vim.print(lines)
  end,
}

---@alias traverser function(character: string): traverser | string[]

---@param first position
---@param last  position
---@param step  number
---@param traverser function(character: string):
M.traverse_file = function(first, last, step, traverser)
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return position.last()
end

M.reload_codebase = function() end

M.open_path = function(path)
  vim.print(vim.fn.expand("<cfile>"))
end

return M
