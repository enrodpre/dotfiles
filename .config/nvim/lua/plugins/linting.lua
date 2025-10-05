return {
  {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        cpp = { "cppcheck", },
        python = { "pylint" },
        zsh = { "bash",
          -- "shellcheck",
          "zsh" },
      },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          -- opts.linters_by_ft[vim.bo.filetype]
          require("lint").try_lint()
        end
      })
    end
  }
}
