return {
  {
    "mfussenegger/nvim-dap-python",
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
    config = function()
      require("venv-selector").setup({})
    end,
    branch = "regexp",
  }
}
