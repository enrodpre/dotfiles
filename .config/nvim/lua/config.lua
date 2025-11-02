local C   = {
  colorscheme = "tokyonight",
  fuzzy_finder = "fzf-lua",
  open_quickfix = function() require('trouble').open('quickfix') end,
  diagnostics = {
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
  }
}
_G.Config = C


C.setup = function()
  require("keymaps")

  vim.diagnostic.config(C.diagnostics)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      require(C.colorscheme)
      vim.cmd.colorscheme(C.colorscheme)
    end
  })
end

return C
