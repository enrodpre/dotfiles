local delete = {
  gc = { "x", "n" },
  gcc = { "n" },
}

for lhs, modes in pairs(delete) do
  --- @type table
  for _, mode in ipairs(modes) do
    vim.api.nvim_del_keymap(mode, lhs)
  end
end
