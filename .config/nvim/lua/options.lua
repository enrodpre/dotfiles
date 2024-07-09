-- sidescroll = 5,
-- cmdheight = 1,
-- ruler = false,
-- ignorecase = true,
-- numberwidth = 2,
-- showcmd = true,
-- wrapmargin = 300

-- Close hidden buffers
vim.g.hidden = false
vim.g.bufhidden = "delete"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Indentation
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4


-- Folding
-- vim.o.foldmethod = "indent"
-- vim.o.foldenable = false
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufdddo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Relative numbers
vim.o.relativenumber = false

vim.g.python3_host_prog = "/home/kike/.local/share/virtualenvs/neovim/bin/python"
