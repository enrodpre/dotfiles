-- _G.__is_log = true

local C = {
  colorscheme = "tokyonight",
  fuzzy_finder = "fzf-lua",
  open_quickfix = function()
    require("trouble").open("quickfix")
  end,
  diagnostics = {
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
  },
}

C.lsp_servers = function()
  local files = vim.fn.globpath(
    vim.fn.stdpath("config") .. "/after/lsp",
    "*.lua",
    false,
    true
  )
  return vim.tbl_map(function(row)
    return vim.fn.fnamemodify(row, ":t:r")
  end, files)
end

-- selene: allow(global_usage)
_G.Config = C

C.setup = function()
  require("keymaps")

  vim.diagnostic.config(C.diagnostics)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      require(C.colorscheme)
      vim.cmd.colorscheme(C.colorscheme)
    end,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local bufnr = ctx.buf
    local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end
})

vim.api.nvim_create_user_command("Toggle", function(args)
  -- if args.nargs < 1 then
  --   return
  -- end

  for _, opt in ipairs(args.fargs) do
    vim.g[opt] = not vim.g[opt]
    vim.print(string.format("%s option is now %s", opt, vim.g[opt]))
  end
end, {
  nargs = 1,
  complete = function()
    return { "autoformat" }
  end,
})


return C
