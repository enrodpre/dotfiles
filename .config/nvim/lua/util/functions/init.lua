local F = {}

function F.put_text(...)
   local objects = {}
   for i = 1, select("#", ...) do
      local v = select(i, ...)
      table.insert(objects, vim.inspect(v))
   end

   local lines = vim.split(table.concat(objects, "\n"), "\n")
   local lnum = vim.api.nvim_win_get_cursor(0) [1]
   vim.fn.append(lnum, lines)
   return ...
end

function F.trim(s) return s:gsub("[\n]", "") end

function F.get_selected_text()
   local visual = vim.fn.mode() == "v"

   if visual == true then
      local saved_reg = vim.fn.getreg "v"
      vim.cmd [[noautocmd sil norm! "vy]]
      local sele = vim.fn.getreg "v"
      vim.fn.setreg("v", saved_reg)
      return sele
   else
      return vim.fn.expand "<cWORD>"
   end
end

function F.get_selected(opts)
   local as = opts.as or "obj"
   local selected_text = F.get_selected_text()

   if as == "text" then
      return selected_text
   elseif as == "obj" then
      local loader, err = load("return " .. F.trim(selected_text))
      if loader then
         local obj = loader()
         return vim.inspect(obj)
      else
         print("error calling to func ", err)
      end
   else
      error("Bad assss")
   end
end

function F.fg(name)
   ---@type {foreground?:number}?
   local hlgrp = vim.api.nvim_get_hl(0, {
      name = name,
   })
   return hlgrp and hlgrp.foreground
end

function F.map(table_map)
   for lhs, described_action in pairs(table_map) do
      local desc, modes, rhs, opts = unpack(described_action)
      opts = opts or {}
      opts.desc = desc
      vim.keymap.set(vim.split(modes, ""), lhs, rhs, opts)
   end
end

local external_files_functions = vim.split(vim.fn.glob(
      "~/.config/nvim/lua/util/functions/*.lua"),
   "\n")

for _, file in pairs(external_files_functions) do
   local filename = vim.fn.fnamemodify(file, ":t:r")
   if filename ~= "init" then
      local func = require("util.functions." .. filename)
      F [filename] = func
   end
end

return F
