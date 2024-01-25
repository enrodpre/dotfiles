-- desc modes shortcut action opts

local M = {
  ["<F4>"] = { "Execute last command", "n", ":<UP><CR>" },
  [",i"] = { "Insert one caracter", "n", "i_<Esc>r" },
  [",a"] = { "Append one caracter", "n", "a_<Esc>r" },
  ["<C-o>"] = { "Insert new line in normal mode", "n", "a<CR><Esc>" },
  ["oo"] = { "Newline forward without entering insert mode", "n", "o<Esc>k", _ = "which_key_ignore" },
  ["OO"] = { "Newline forward without entering insert mode", "n", "0i<CR><Esc>" },
  ["e"] = { "Execute selected text in a terminal", "v", 'y:!<C-r>"<CR>' },
  ["<leader>qq"] = { "Force quit", "n", ":q! <CR>" },
  ["<leader>ww"] = { "Save", "n", ":w <CR>" },
  ["<leader>wq"] = { "Save and quit", "n", ":wq <CR>" },
  ["<Space>"] = { "Map space to nop", "nv", "<Nop>", { silent = true } },
  ["k"] = { "Remap for dealing with word wrap", "n", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
  ["j"] = { "Remap for dealing with word wrap", "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
  ["[d"] = { 'Go to previous diagnostic message', "n", vim.diagnostic.goto_prev },
  ["]d"] = { "Go to next diagnostic message", "n", vim.diagnostic.goto_next },
  ["<leader>f"] = { "Open floating diagnostic message", "n", vim.diagnostic.open_float },
  ["<leader>o"] = { "Open diagnostics list", "n", vim.diagnostic.setloclist },
}

return vim.lua.loader(vim.lua.map, M)
