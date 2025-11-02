local autosource = {
  files = {},
}

function autosource.setup()
  vim.api.nvim_create_user_command("Autosource", function()
    local augroup = vim.api.nvim_create_augroup("autosource", {})
    local bufid = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufid)
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      pattern = bufname,
      callback = function()
        vim.cmd("source " .. bufname)
        vim.notify("Sourced " .. bufname, vim.log.levels.INFO)
      end
    })

    table.insert(autosource.files, bufname)
    vim.notify("Autosourcing " .. bufname, vim.log.levels.INFO)
  end, {})

  vim.api.nvim_create_user_command("AutosourceList", function()
    vim.print(autosource.files)
  end, {})
end

return autosource
