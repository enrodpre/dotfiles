return {
  enabled = false,
  "ThePrimeagen/refactoring.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    prompt_func_return_type = {
      cpp = true,
      c = true,
      h = true,
      hpp = true,
    },
    prompt_func_param_type = {
      cpp = true,
      c = true,
      h = true,
      hpp = true,
    },
  },
}
