-- sidescroll = 5,
-- clipboard = "unnamedplus",
-- cmdheight = 1,
-- ruler = false,
-- hidden = true,
-- ignorecase = true,
-- smartcase = true,
-- number = true,
-- numberwidth = 2,
-- relativenumber = false,
-- expandtab = true,
-- shiftwidth = 2,
-- smartindent = true,
-- tabstop = 8,
-- timeoutlen = 700,
-- updatetime = 250,
-- undofile = true,
-- showcmd = true,
-- wrapmargin = 300

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Relative numbers
vim.o.relativenumber = false

vim.g.python3_host_prog = '/home/kike/.config/nvim/.venv/bin/python3'
