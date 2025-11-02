---@class Spec
---@field name string
---@field opts? table<string,any>
local Spec = {}


---@class Lang
---@field plugins? any[]
---@field keymaps? any[]
---@field lsp? Spec
---@field formatter? Spec
---@field linter? Spec
local Lang = {}
Lang.__index = Lang

---@param opts Lang
function Lang:new(opts)
  local obj = opts
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Lang:_setup_keymaps()
  for _, keymap in ipairs(self.keymaps) do
    keymap.opts = keymap.opts or {}
    keymap.opts.buffer = true
    local mode = keymap.opts.mode or "n"
    keymap.opts.mode = nil

    vim.keymap.set(mode, keymap[1], keymap[2], keymap.opts)
  end
end

function Lang:_setup_plugins()
  require("lazy").load(self.plugins)
end

function Lang:_setup_lsp()
  if self.lsp.opts then
    vim.lsp.config(self.lsp.name, self.lsp.opts)
  end
  vim.lsp.enable(self.lsp.name)
end

function Lang:_setup_formatter()
  require("conform").formatters[self.formatter] = {}
end

function Lang:_setup_linter()
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      require('lint').try_lint(self.linter)
    end
  })
end

function Lang:setup()
  require("lazy").load({ "neovim/nvim-lspconfig", }, "", {})

  for _, fn in ipairs(self) do
    vim.print("setup ")
    vim.print(fn)
    if not Lua.is_empty(self[fn]) then
      self["_setup_" .. fn](self)
    end
  end
end

return {
  Lang = Lang,
  setup_lang = function(opts)
    Lang:new(opts):setup()
  end,
  setup = function() _G.Lang = Lang end
}
