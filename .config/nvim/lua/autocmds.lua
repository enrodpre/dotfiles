vim.api.nvim_create_autocmd("User", {
  desc = "Disable some defalt mapping",
  pattern = "LazyLoad",
  callback = function()
    local delete = {
      gc = { "x", "n", },
      gcc = { "n", },
    }

    for lhs, modes in pairs(delete) do
      --- @type table
      for _, mode in ipairs(modes) do
        vim.api.nvim_del_keymap(mode, lhs)
      end
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "Sets shebang when creating a new bash script",
  pattern = "*sh",
  callback = function()
    local program = "zsh"
    local shebang = string.format("/usr/bin/env " .. program)

    vim.api.nvim_put({ "#!" .. shebang, }, "", true, true)
    vim.fn.append(1, "")
    vim.fn.append(1, "")
    vim.fn.cursor({ 3, 0, })
  end,
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
  clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights when yanking",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "[No Name]",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

local grp = vim.api.nvim_create_augroup("write_pre", { clear = false, })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = grp,
  callback = function(args)
    if #vim.lsp.get_clients() > 0 then
      vim.lsp.buf.format({ bufnr = args.buf, })
    end
  end,
})
