return {
  desc = "Open qflist when populated",
  constructor = function()
    return {
      on_exit = function(_, _, code)
        vim.print(code)
        if code ~= 0 then
          Config.open_quickfix()
        end
      end,
    }
  end,
}
