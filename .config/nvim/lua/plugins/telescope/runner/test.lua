#!/usr/bin/lua

local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)

local function asd()
   vim.cmd("e data.lua")
   vim.api.nvim_win_set_cursor(0, { 27, 25, })
   require("plugins.telescope.builtin").inspect()

   -- vim.api.nvim_input("<CR>jjj")
   vim.api.nvim_feedkeys(enter, "n")
end

-- local timer = vim.loop.new_timer()
-- timer:start(500, 0, vim.schedule_wrap(asd))
vim.schedule(asd)
