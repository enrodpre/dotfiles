vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.autoformat = true
vim.g.minwidth = 80

vim.o.cmdheight = 0
vim.o.showmode = false          -- Don't show mode in command line
vim.o.ruler = false             -- Don't show cursor position
vim.o.showcmd = true
vim.o.showcmdloc = "statusline" -- Don't show partial command
vim.o.confirm = true
vim.o.exrc = false
vim.o.grepprg = "rg --vimgrep"
vim.o.hidden = true
vim.o.bufhidden = "delete"
vim.o.hlsearch = true
vim.o.wrap = true
vim.o.sidescroll = 0
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorlineopt = "both"
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smartcase = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.laststatus = 2
vim.o.termguicolors = true

-- seen somewhere, its supposed to reduce delay
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.spelllang = { "en", "es" }
