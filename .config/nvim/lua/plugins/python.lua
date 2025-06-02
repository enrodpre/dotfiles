vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.lsp.config("pylsp",
      {
        settings = {
          plugins = {
            -- formatter options
            black = { enabled = true },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options
            pyflakes = { enabled = false },
            pycodestyle = { enabled = true },
            -- type checker
            pylsp_mypy = { enabled = true, },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            pylsp_isort = { enabled = true },
            rope_completion = { enabled = true },
            rope_autoimport = {
              enabled = true,
            },
          }
        }
      }
    )
    vim.lsp.enable("pylsp")
  end
})
return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local executable = (os.getenv("VIRTUAL_ENV") or "/usr") .. "/bin/python"
      require("dap-python").test_runner = "pytest"
      require("dap-python").setup(executable)
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'My custom launch configuration',
        program = '${file}',
      })
    end
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    opts = { name = ".venv", },
    branch = "regexp",
  }
}
