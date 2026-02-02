vim.api.nvim_create_autocmd("User", {
  desc = "Disable some defalt mapping",
  pattern = "LazyLoad",
  callback = function()
    local delete = {
      gc = { "x", "n", },
      gcc = { "n", },
    }

    for lhs, modes in pairs(delete) do
      --- @type table
      for _, mode in ipairs(modes) do
        vim.api.nvim_del_keymap(mode, lhs)
      end
    end
  end,
  once = true,
})

local lazyreq = Lua.required_on_exported_call

local smart_splits = function(fn)
  return lazyreq("smart-splits")[fn]
end

return {
  { "<M-h>",     smart_splits("move_cursor_left") },
  { "<M-j>",     smart_splits("move_cursor_down") },
  { "<M-k>",     smart_splits("move_cursor_up") },
  { "<M-l>",     smart_splits("move_cursor_right") },
  { "<D-h>",     smart_splits("resize_left") },
  { "<D-j>",     smart_splits("resize_down") },
  { "<D-k>",     smart_splits("resize_up") },
  { "<D-l>",     smart_splits("resize_right") },
  { "<S-M-h>",   smart_splits("swap_buf_left") },
  { "<S-M-j>",   smart_splits("swap_buf_down") },
  { "<S-M-k>",   smart_splits("swap_buf_up") },
  { "<S-M-l>",   smart_splits("swap_buf_right") },
  { "<leader>p", group = "[P]rint", },
  {
    ",r",
    function()
      vim.cmd("luafile %")
      vim.print(string.format("Reloaded %s file.", vim.fn.expand("%")))
    end,
    desc = "[R]eload current file",
  },
  {
    ",p",
    function()
      Lua.get_lsp_diagnostic_information()
    end,
    desc = "Print more info about diagnostic",
  },
  {
    "<c-[",
    proxy = "<c-o>",
    desc = "Go back (<C-O>)",
  },
  { "<", "<gv", mode = "v", },
  { ">", ">gv", mode = "v", },
  {
    ",o",
    "a<CR><Esc>",
    desc = "Put next line in next character",
  },
  {
    {
      "<C-Q>",
      ":q <CR>",
      desc = "Quit neovim",
      noremap = false,
    },
    {
      "<C-Q><C-Q>",
      ":q! <CR>",
      desc = "Force quit",
    },
  },
  {
    "<leader>s",
    group = "[S]et",
  },
  {
    "<C-s>",
    "<cmd>w<CR>",
    desc = "Save",
  },
  {
    "<C-s><C-a>",
    "<cmd>wa<CR>",
    desc = "Save all buffers",
  },
  {
    "g",
    group = "[G]o",
  },
  {
    "<leader>t",
    group = "[T]elescope",
  },
  {
    "<leader>f",
    group = "[F]ind",
  },
  {
    "<leader>fg",
    group = "[G]rep",
  },
  {
    "<leader>l",
    group = "[L]azy",
  },
  {
    "<S-CR>",
    function()
      require("noice").redirect(vim.fn.getcmdline())
    end,
    desc = "Redirect output of command line",
    mode = "c",
  },
  {
    "<Esc>",
    "<Esc>:let @/ = ''<CR>",
    desc = "Escape will clear search pattern",
    silent = true,
  },
  { "<leader>e", group = "[E]xecute", },
  -- { "<Esc>",     "<C-c>",             desc = "Better escape", },
  {
    "<leader>d",
    group = "[D]ap",
  },
  {
    {
      "<leader>o",
      group = "[O]pen",
    },
    {
      "<leader>op",
      function()
        require("lazy").show()
      end,
      desc = "[O]pen Lazy",
    },
    {
      "<leader>om",
      "<cmd>messages<cr>",
      desc = "[O]pen [M]essages",
    },
  },
  {
    {
      "<C-w>", [[<C-\><C-n><C-w>]], mode = "t",
    },

  },
}
