local ensure_installed = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "diff",
  "json",
  "lua",
  "luadoc",
  "luap",

  "markdown",
  "markdown_inline",

  -- "nvim",
  "python",
  "query",
  "regex",
  "vim",
  "vimdoc",
  "yaml",
}

return
{
  "nvim-treesitter/nvim-treesitter",
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  build = ":TSUpdate",
  -- cmd = { "TSUpdateSync" },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<C-space>",
  --     node_incremental = "<C-space>",
  --     scope_incremental = false,
  --     node_decremental = "<bs>",
  --   },
  -- },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true, },
      ensure_installed = ensure_installed,
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    })
  end,
}
