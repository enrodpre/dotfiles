local function find_alternate_files()
  local file = vim.fn.expand('%:t')
  local filename = vim.fn.expand('%:t:r')

  local fzf = require "fzf-lua"
  local fd_opts = { "-t", "f",
    "--exclude", file, "--exclude", "build",
    "-g", filename .. ".*" }
  fzf.files {
    fd_opts = table.concat(fd_opts, " ")
  }
end

local opts = {
  keymaps = {
    { "gdh", find_alternate_files, opts = { desc = "[Go] to other compilation unit files", } },
  },
}

local surroundings = {
  move = { "std::move(", ")", },
  optional = { "std::optional<", ">", },
  cref = { "const ", "&", },
}



local function toggle_reference_operator()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  if line:sub(col, col) == "." then
    Lua.replace_line("->", col, col)
  elseif col <= #line and line:sub(col, col + 1) == "->" then
    Lua.replace_line(".", col, col + 1)
  elseif col > 1 and line:sub(col - 1, col) == "->" then
    Lua.replace_line(".", col - 1, col)
  end
end

-- vim.cmd [[packadd termdebug]]
vim.api.nvim_create_autocmd("User", {
  pattern = "TermdebugStartPre",
  callback = function()
    vim.cmd [[let g:termdebug_wide = 1]]
  end
})

vim.api.nvim_create_user_command("Debug",
  function()

  end,
  {})



local local_mapping = {
  -- { "<leader>bt", function() return Gdb.toggle_gdb_breakpoint() end, desc = 'Toggle GDB breakpoint' },
  -- { "<leader>bc", function() return Gdb.clear_all_breakpoints() end, desc = 'Clear all GDB breakpoints' },
  -- { "<leader>bl", function() return Gdb.list_breakpoints() end,      desc = 'List GDB breakpoints' },
  -- {
  --   "<leader>bs",
  --   function()
  --     Lua.gdb.clear_all_breakpoints()
  --     return Lua.gdb.toggle_gdb_breakpoint()
  --   end,
  --   desc = 'List GDB breakpoints'
  -- },
  { ",c",  desc = "[C]hange node", },
  { ",cp", desc = "[C]ange node toggle dot <-> arrow", toggle_reference_operator },
  {
    ",cr",
    function() Lua.surround_with_textobj(surroundings.cref) end,
    desc = "[C]hange node add std::move",
  },
  {
    ",cm",
    function()
      Lua.surround_with_textobj(surroundings.move)
    end,
    desc = "[C]hange node add std::move",
  },
  {
    ",co",
    function()
      Lua.surround_node(surroundings.optional)
    end,
    desc = "[C]hange node add std::optional",
  },
  { ",cu", Lua.unfold_node {}, desc = "[N]ode [U]nfold", },
}

local function create_commands()
  local build_path = "build/dev-test"

  local function run_test(test)
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        vim.g.last_tests_result = vim.v.event.status
      end,
      once = true
    })
    local term = require("snacks.terminal")
    local cmd = { "ctest" }

    local args
    if not test then
      args = { "--preset", "unit" }
    else
      args = { "--test-dir", build_path, "-R", test }
    end

    table.insert(args, "--output-on-failure")

    if vim.g.last_tests_result and vim.g.last_tests_result ~= 0 then
      table.insert(args, "--rerun-failed")
    end

    for _, arg in ipairs(args) do
      table.insert(cmd, arg)
    end

    term.get(cmd, {
      win = { bo = { filetype = "test_executor", } },
      on_exit = function()
        vim.print('a')
      end
    })
  end


  vim.api.nvim_create_user_command("RunTest",
    function()
      local command = "ctest"
      local args = { "--test-dir", build_path, "--show-only=json-v1" }
      local runner = require('plenary.job')
      local job = runner:new({
        command = command,
        args = args,
        on_exit = function(json_data, _, _)
          vim.schedule(function()
            local json_str = ""
            for _, v in pairs(json_data:result()) do
              json_str = json_str .. v
            end
            local tests = {}
            local result = vim.fn.json_decode(json_str)
            for _, item in ipairs(result.tests) do
              table.insert(tests, item["name"])
            end

            vim.ui.select(tests, {}, function(idx)
              if not idx then
                vim.notify("No test was selected", 4)
                return
              end

              run_test(idx)
            end)
          end)
        end
      })

      job:start()
    end, {})

  vim.api.nvim_create_user_command("RunTests", function()
    run_test()
  end, {})
end

vim.api.nvim_create_user_command("CmmSetFile", function(command)
  vim.system({ "ln", "-sf", command.fargs[1], "current.cmm" })
  local exit_code = vim.v.shell_error
  if exit_code == 0 then
    vim.print("Created successfully a symlink of " .. command.fargs[1])
  else
    vim.print(string.format("CmmSetFile returned %d", exit_code))
  end
end, { nargs = 1 })

vim.lsp.enable("clangd")

local wk = require("which-key")
wk.add(local_mapping)

vim.cmd [[set makeprg=cmake\ --build\ --preset\ dev-test]]
create_commands()
