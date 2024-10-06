vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
  pattern = "*",
  callback = function(args)
    if vim.t.bufs == nil then
      vim.t.bufs = { args.buf }
    else
      local bufs = vim.t.bufs

      -- check for duplicates
      if not vim.tbl_contains(bufs, args.buf) and (args.event == "BufAdd" or vim.bo[args.buf].buflisted) then
        table.insert(bufs, args.buf)
        vim.t.bufs = bufs
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufks
      if not bufs then
        return
      end

      for i, bufnr in ipairs(bufs) do
        if bufnr == args.buf then
          table.remove(bufs, i)
          vim.t[tab].bufs = bufs
          break
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "Sets shebang when creating a new file",
  pattern = "*.sh",
  callback = function()
    local program = "zsh"
    local shebang = string.format("/usr/bin/env " .. program)

    vim.api.nvim_put({ "#!" .. shebang }, "", true, true)
    vim.fn.append(1, "")
    vim.fn.append(1, "")
    vim.fn.cursor({ 3, 0 })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*.py",
  callback = function()
    local _, err = pcall(require, "venv-selector")
    if err then
      return
    end
    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
    print(venv)
    if venv ~= "" then
      require("venv-selector").retrieve_from_cache()
    end
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

-- close some filetypes with <q>
-- use :ls or bufname()
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
    "*.log",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    ok,err = pcall(require,"lint")
    if ok then
      require("lint").try_lint()
    end
  end,
})
