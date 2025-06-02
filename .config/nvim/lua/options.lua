vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.grepprg = "rg --vimgrep"
opt.hidden = false
opt.bufhidden = "delete"
opt.hlsearch = true
opt.wrap = false
opt.linebreak = true
opt.matchpairs = "(:),{:},[:],<:>"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.expandtab = true
opt.smartindent = true
opt.smartcase = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.undofile = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300

vim.g.loaded_perl_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_ruby_provider = false

vim.b.minwidth = 80
vim.o.termguicolors = true
