vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.?pp",
  callback = function()
    vim.api.nvim_create_user_command("erase_word", function(find)
      local current_line = vim.api.nvim_get_current_line()
      local new_line = current_line:gsub(find, "")
      vim.api.nvim_set_current_line(new_line)
    end, {})

    vim.api.nvim_create_user_command("surround_word", function(surr)
      local left = surr.left or ""
      local right = surr.right or ""

      local current_word = vim.fn.expand("<cWORD>")
      local new_word = left .. current_word .. right
      local current_line = vim.api.nvim_get_current_line()
      local new_line = current_line:gsub(current_word, new_word)

      vim.api.nvim_set_current_line(new_line)
    end, {})
  end
})
