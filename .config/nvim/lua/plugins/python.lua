vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.py' },
  callback = function()
    vim.lsp.config("pylsp",
      {
        settings = {
          plugins = {
            -- formatter options
            black = { enabled = true, line_length = 88 },
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
    enabled = false,
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local executable = (os.getenv("VIRTUAL_ENV") or "/usr") .. "/usr/bin/env python"
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
    },
    ft = "python",
    opts = { name = ".venv", },
    config = function(_, opts)
      require("venv-selector").setup(opts)
      vim.cmd [[VenvSelect]]
    end
  }
}
