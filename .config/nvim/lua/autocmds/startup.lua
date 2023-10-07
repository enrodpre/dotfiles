local startup = {}

startup.enter = {
  event = "VimEnter",
  pattern = "*",
  callback = function()
    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
    if venv ~= "" then
      require("venv-selector").retrieve_from_cache()
    end
  end,
  desc = "Auto select virtualenv Nvim open",
}

return startup
