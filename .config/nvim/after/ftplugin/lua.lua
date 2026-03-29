vim.api.nvim_create_user_command("FormatLuaTable",
  function()
    require("library.editor").format_lua_table()
  end,
  {
    desc =
    "Format inline Lua tables into multi-line style",
  })
