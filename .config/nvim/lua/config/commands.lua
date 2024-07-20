#!/usr/bin/lua


-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
   -- Use the current buffer's path as the starting point for the git search
   local current_file = vim.api.nvim_buf_get_name(0)
   local current_dir
   local cwd = vim.fn.getcwd()
   -- If the buffer is not associated with a file, return nil
   if current_file == "" then
      current_dir = cwd
   else
      -- Extract the directory from the current file's path
      current_dir = vim.fn.fnamemodify(current_file, ":h")
   end

   -- Find the Git root directory from the current file's path
   local git_root = vim.fn.systemlist("git -C " ..
      vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel") [1]
   if vim.v.shell_error ~= 0 then
      print "Not a git repository. Searching on current working directory"
      return cwd
   end
   return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
   local git_root = find_git_root()
   if git_root then
      require("telescope.builtin").live_grep {
         search_dirs = { git_root, },
      }
   end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

local run_every_code_action_buffer = function()
   -- Get the current buffer number
   local bufnr = vim.api.nvim_get_current_buf()

   local diagnostics = vim.diagnostic.get(bufnr, {
      severity = {
         vim.diagnostic.severity.WARN,
         vim.diagnostic.severity.ERROR,
      },
   })

   -- vim.print(#diagnostics)
   -- vim.print(diagnostics)
   -- for _, diag in ipairs(diagnostics) do
   --    print_sep()
   --    print("lnum", diag.lnum)
   --    print("col", diag.col)
   --    print_sep()
   -- end

   for _, diag in ipairs(diagnostics) do
      -- local start = { diag.lnum + 1, diag.col + 1, }
      local start = { 21, 29, }
      local _end = { 6, 0, }
      local params = {
         apply = true,
         filter = function(a) return a.isPreferred end,
         range = {
            start = start,
            ["end"] = start,
         },
      }
      -- vim.lsp.buf_request_all(bufnr, "textDocument/codeAction", params,
      --    function(error, results, context, config)
      --       vim.print(error)
      --       vim.print(results)
      --       vim.print(context)
      --       vim.print(config)
      --    end)
      --
      --

      vim.lsp.buf.code_action(params)

      break
   end
end
vim.api.nvim_create_user_command("RunAllCodeAction", run_every_code_action_buffer,
   {})
