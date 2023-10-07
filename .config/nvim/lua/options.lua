local options = {
  o = {
    sidescroll = 5,
    clipboard = "unnamedplus",
    cmdheight = 1,
    ruler = false,
    hidden = true,
    ignorecase = true,
    smartcase = true,
    mapleader = " ",
    mouse = "a",
    number = true,
    numberwidth = 2,
    relativenumber = false,
    expandtab = true,
    shiftwidth = 2,
    smartindent = true,
    tabstop = 8,
    timeoutlen = 700,
    updatetime = 250,
    undofile = true,
    showcmd = true,
    wrapmargin = 300,
    --fillchars = { eob = " " },
    -- path = vim.opt.path .. ":" .. vim.fn.stdpath "config" .. "/lua/functions",
  },
  g = {
    mapleader = " ",
    mapleaderlocal = " ",
    debug = false,
  }
}

local load = {}

function load.load()
  -- Noremap default
  local keymap_set = vim.keymap.set
  vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap or true
    -- opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
  end

  -- In case there was nothing before
  local ll = vim.list_extend
  vim.list_extend = function(t, ...)
    t = t or {}
    return ll(t, ...)
  end



  for target, parameter in pairs(options) do
    for name, value in pairs(parameter) do
      vim[target][name] = value
    end
  end
end

return load
