local T = {
  exit_code = 0
}

T.opts = {
  start_insert = false,
  auto_insert = false,
  auto_close = false
}

function T.get()
  return Snacks.terminal.get(nil, T.opts)
end

function T.cwd()
  local term_buf = T.get()
  local term_id = vim.bo[term_buf.buf].channel
  local term_pid = vim.fn.jobpid(term_id)
  return vim.uv.fs_readlink(string.format("/proc/%d/cwd", term_pid))
end

-- Table to store the last exit code per terminal buffer


local function create_termopen_autocmd()
  local osc_pattern = "\027%]51;ExitCode=(%d+)\007"

  vim.api.nvim_create_autocmd("TermRequest", {
    callback = function(args)
      local bufnr = args.buf
      vim.api.nvim_buf_attach(bufnr, false, {
        on_lines = function() end, -- required dummy
        on_bytes = function() end,
        on_detach = function() end,
        on_changedtick = function() end,
        on_event = function() end,
        on_output = function(_, data)
          if not data then return end
          for _, line in ipairs(data) do
            local code = line:match(osc_pattern)
            if code then
              T.exit_code = tonumber(code)
            end
          end
        end,
      })
    end,
  })
end

T.statusline = {
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      T.cwd
    },
    -- lualine_y = { function() return "a" end },
  },
  filetypes = { "snacks_terminal" },
}

-- Attach listener when opening a terminal
function T.setup()
  -- create_termopen_autocmd()

  vim.keymap.set({ "n", "t" }, [[<c-\>]], function()
    Snacks.terminal.toggle(nil, T.opts)
  end, { desc = "Toggle Terminal" })
end

return T
