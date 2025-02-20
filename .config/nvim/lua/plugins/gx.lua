return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x", }, }, },
  cmd = { "Browse", },
  init = function()
    vim.g.netrw_nogx = 1
  end,
  dependencies = { "nvim-lua/plenary.nvim", },
  config = function()
    require("gx").setup({
      open_browser_app = "xdg-open",
      open_browser_args = {},
      handlers = {
        plugin = true,
        github = true,
        package_json = true,   -- open dependencies from package.json
        search = true,
      },
      handler_options = {
        search_engine = "duckduckgo",
        select_for_search = false,   -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
        git_remotes = { "upstream", "origin", },
        git_remote_push = false,
      },
    })
  end,
}
