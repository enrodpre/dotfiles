local function dap()
  return require("dap")
end

local function cpp_conf()
  local adapter = {
    cpp = {
      id = "cpp",
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", },
    },
  }
  local configurations = {
    cpp = {
      {
        name = "Run cmm (GDB)",
        type = "cpp",
        request = "launch",
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
          local executable = "CmmLang"
          local path = vim.fs.joinpath(vim.fn.getcwd(), executable)
          if vim.uv.fs_lstat(path) then
            return path
          else
            return vim.fn.input({
              prompt = "Path to executable: ",
              default = vim.fn.getcwd() .. "/",
              completion = "file",
            })
          end
        end,
        args = function()
          local testfile = "TESTFILE"
          local path = vim.fs.joinpath(vim.fn.getcwd(), testfile)
          if vim.uv.fs_lstat(path) then
            return path
          else
            dap().ABORT()
          end
        end,
      },
      {
        name = "Run executable (GDB)",
        type = "cpp",
        request = "launch",
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
          local path = vim.fn.input({
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            completion = "file",
          })

          return (path and path ~= "") and path or dap().ABORT
        end,
      },
      {
        name = "Run executable with arguments (GDB)",
        type = "cpp",
        request = "launch",
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
          local path = vim.fn.input({
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            completion = "file",
          })

          return (path and path ~= "") and path or dap().ABORT
        end,
        args = function()
          local args_str = vim.fn.input({
            prompt = "Arguments: ",
          })
          return vim.split(args_str, " +")
        end,
      },
      {
        name = "Attach to process (GDB)",
        type = "cpp",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    },
  }

  return adapter, configurations
end
return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>da",
        function() dap().toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
      },

      {
        "<leader>dc",
        function() dap().continue() end,
        desc = "Continue",
      },

      {
        "<leader>dC",
        function() dap().run_to_cursor() end,
        desc = "Run to Cursor",
      },

      {
        "<leader>dT",
        function() dap().terminate() end,
        desc = "Terminate",
      },
    },
    config = function()
      local dap = dap()
      local adapter, configurations = cpp_conf()
      dap.adapters = adapter
      dap.configurations = configurations
    end,
  },
}
