#!/usr/bin/lua

local M = {}

M.put_line = function(number, payload)
  payload = payload or ""

  vim.api.nvim_buf_set_lines(0, number, number, false, { payload })
end

return M
