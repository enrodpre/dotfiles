local opt = vim.opt

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Close hidden buffers
opt.hidden = false
opt.bufhidden = "delete"

opt.virtualedit = "none"
-- Set highlight on search
opt.hlsearch = true

-- Dimensions
opt.textwidth = 90
opt.columns = 87

-- Make line numbers default
opt.number = true
opt.cursorline = true -- Enable highlighting of the current line

-- Enable mouse mode
opt.mouse = "a"

-- vim.g.lualine_laststatus
opt.laststatus = 2

-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"

-- Indentation
opt.breakindent = true
opt.expandtab = true
opt.smartindent = true
opt.smartcase = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.foldmethod = "indent"
-- opt.foldenable = false
opt.foldcolumn = "0"
opt.foldlevel = 99 -- Using ufdddo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.smoothscroll = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Relative numbers
opt.relativenumber = true

vim.o.termguicolors = true
