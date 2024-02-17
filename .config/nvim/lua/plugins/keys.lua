#!/usr/bin/lua

local M = {
   -- ["<leader>at"] = {
   --    "[A]ctions [T]oggle", "n", require("nvim-toggler").toggle,
   -- },
   ["<F4>"] = {
      "Execute last command", "n", ":<UP><CR>",
   },
   [",i"] = {
      "Insert one caracter", "n", "i_<Esc>r",
   },
   [",a"] = {
      "Append one caracter", "n", "a_<Esc>r",
   },
   ["<C-o>"] = { "Insert new line in normal mode", "n", "a<CR><Esc>", },
   ["oo"] = {
      "Newline forward without entering insert mode",
      "n",
      "o<Esc>k",
   },
   ["OO"] = {
      "Newline forward without entering insert mode",
      "n", "0i<CR><Esc>",
   },
   ["e"] = {
      "Execute selected text in a terminal", "v",
      "y:!<C-r>\"<CR>",
   },
   ["<C-Q>"] = { "Quit neovim", "nv", ":q <CR>", },
   ["<C-Q><C-Q>"] = {
      "Force quit", "n", ":q! <CR>",
   },
   ["<C-s>"] = { "Save", "n", ":w <CR>", },
   -- ["<Space>"] = { "Map space to nop", "nv", "<Nop>", { silent = true } },
   go = {
      "Remap for <C-O>", "n", "<C-O>",
      { remap = true, },
   },
   -- gi = { "Remap for <C-I>", "n", "<C-I>", { remap = true } }
}
-- for _, map in pairs(M) do assert(type(map[2])) end

return {
   "folke/which-key.nvim",
   lazy = false,
   opts = {
      operators = { ["<leader>c"] = "Comments", },
      triggers_blacklist = { n = { "o", "oo", }, },
   },
   config = function (opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.register {
         ["<leader>a"] = {
            name = "[A]ctions",
            _ = "which_key_ignore",
         },
         ["<leader>d"] = {
            name = "[D]ocument",
            _ = "which_key_ignore",
         },
         ["<leader>g"] = {
            name = "[G]it",
            _ = "which_key_ignore",
         },
         ["<leader>h"] = {
            name = "Git [H]unk",
            _ = "which_key_ignore",
         },
         ["<leader>r"] = {
            name = "[R]ename",
            _ = "which_key_ignore",
         },
         ["<leader>s"] = {
            name = "[S]earch",
            _ = "which_key_ignore",
         },
         ["<leader>t"] = {
            name = "[T]elescope",
            _ = "which_key_ignore",
         },
         ["<leader>W"] = {
            name = "[W]orkspace",
            _ = "which_key_ignore",
         },
         ["o"] = { "which_key_ignore", },
         ["oo"] = { "which_key_ignore", },
         ["O"] = { "which_key_ignore", },
         ["OO"] = { "which_key_ignore", },
      }
      wk.register({
         ["<leader>"] = { name = "VISUAL <leader>", },
         ["<leader>h"] = { "Git [H]unk", },
      }, { mode = "v", })

      for lhs, described_action in pairs(M) do
         local desc, modes, rhs, mapopts = unpack(described_action)
         mapopts = mapopts or {}
         for mode in vim.lua.split(modes) do
            wk.register({
               [lhs] = {
                  rhs,
                  desc,
                  expr = opts["expr"],
                  silent = opts["silent"],
                  remap = opts["remap"],

               },
            }, { mode = mode, })
         end
      end
   end,
}
