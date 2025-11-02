Lang:new {
  formatter = "cmake",
  lsp = { server = "cmake" },
  linter = "cmake_lint",
  plugins = {},
}:setup()

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "CMakeLists.txt", "cmake", "CMakePresets.json" },
  callback = function()
    local overseer = require('overseer')
    overseer.run_template { name = "cmake_gen", function(task)
      vim.notify("run")
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }
        local main_win = vim.api.nvim_get_current_win()
        overseer.run_action(task, "open vsplit")
        vim.api.nvim_set_current_win(main_win)
      end
    end
    }
  end,
})

-- vim.lsp.config("neocmake", {

-- single_file_support = true, -- suggested
-- init_options = {
--   format = {
--     enable = true, -- to use lsp format
--   },
--   lint = {
--     enable = true
--   },
--   semantic_token = false,
-- },
-- filetypes = { "cmake", "CMakeLists.txt", },
-- })
