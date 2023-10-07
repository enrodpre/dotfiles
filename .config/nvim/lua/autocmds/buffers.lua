local buffers = {}
vim.t.bufs = vim.api.nvim_list_bufs()

buffers.add_enter = {
  event = { "BufAdd", "BufEnter" },
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
}

buffers.delete = {
  event = "BuffDelete",
  pattern = "*",
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
}

buffers.unload = {
  event = "BufUnload",
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 0
  end,
}

buffers.format_when_saving = {
  event = "BufWritePre",
  callback = function()
    vim.lsp.buf.formatting_sync()
  end,
}

return buffers
