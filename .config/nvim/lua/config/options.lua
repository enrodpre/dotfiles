-- sidescroll = 5,
-- cmdheight = 1,
-- ruler = false,
-- ignorecase = true,
-- numberwidth = 2,
-- showcmd = true,
-- wrapmargin = 300
local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.b.autoformat = true
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
-- Close hidden buffers
opt.cursorline = true -- Enable highlighting of the current line
opt.hidden = false
opt.bufhidden = 'delete'

-- Set highlight on search
opt.hlsearch = true

-- Make line numbers default
opt.number = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'

-- Indentation
opt.breakindent = true
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4

-- Folding
opt.foldmethod = 'indent'
-- opt.foldenable = false
opt.foldcolumn = '0'
opt.foldlevel = 99 -- Using ufdddo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- opt.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

-- Relative numbers
opt.relativenumber = false

-- vim.o.python3_host_prog = "/home/kike/.local/share/virtualenvs/neovim/bin/python"
