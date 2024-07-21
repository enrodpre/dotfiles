#!/usr/bin/lua

local mapdelay = vim.lua.metatables.default()

local lazy_call = vim.lua.lazyreq.on_module_call

local global_mapping = {
  {
    "<leader>a",
    group = "[A]pply",
  },
  {
    "<C-o>",
    "a<CR><Esc>",
    desc = "Put next line in next character",
  },
  {
    "<leader>d",
    group = "[D]ap",
  },
  {
    "oo",
    "o<Esc>k",
    desc = "Newline forward",
    hidden = true,
  },
  {
    "OO",
    "0i<CR><Esc>",
    desc = "Newline backwards",
    hidden = true,
  },
  {
    "<C-Q>",
    ":q <CR>",
    desc = "Quit neovim",
    noremap = false,
  },
  {
    "<leader>s",
    group = "[S]et",
  },
  {
    "gl",
    group = "[G]o [L]sp",
  },
  {
    "<leader>w",
    group = "[W]orkspace",
  },
  {
    "<leader>x",
    group = "[X] Trouble",
  },
  {
    "<leader>rp",
    group = "[P]rintf",
  },
  {
    "<leader>r",
    group = "[R]efactoring",
  },
  {
    "<leader>c",
    group = "[C]omment",
  },
  {
    "gd",
    group = "[G]o [D]ocument",
  },
  {
    "<C-Q><C-Q>",
    ":q! <CR>",
    desc = "Force quit",
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
    "<C-s>",
    "<cmd>w<CR>",
    desc = "Save",
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
  },
  { "<leader>e", group = "[E]xecute" },
  {
    "<leader>aa",
    function()
      local ft = vim.bo.filetype
      if ft == "python" then
        os.execute("autoimport " .. vim.fn.expand("%:S"))
        vim.cmd("e")
      end
    end,
    desc = "[A]pply [A]utoimport",
  },
  {
    "<leader>at",
    "<Plug>PlenaryTestFile",
    desc = "[A]pply [T]est current file",
  },
  {
    "<leader>n",
    group = "[N]eogen",
  },
  {
    "<leader>nc",
    function()
      require("neogen").generate({})
    end,
    desc = "[C]lass",
  },
  {
    "<leader>om",
    ":messages<CR>",
    desc = "[O]pen [M]essages",
  },
  {
    "<leader>o",
    group = "[O]pen",
  },
  {
    "<leader>ol",
    function()
      require("lazy").show()
    end,
    desc = "[O]pen [L]azy",
  },
  {
    "<leader>u",
    group = "[U]i",
  },
  {
    "<leader>uc",
    lazy_call("notify").dismiss,
    desc = "Notify [C]lose",
  },
  {
    "<leader>g",
    group = "[G]it",
  },
}

local unmap = { "gc", "gcc" }
for _, rhs in ipairs(unmap) do
  table.insert(global_mapping, { rhs, cond = false, hidden = true })
end

table.insert(mapdelay, {
  n = {
    o = 25,
    O = 25,
    oo = 0,
    OO = 0,
  },
})

return {
  "folke/which-key.nvim",
  dependencies = {
    { "echasnovski/mini.icons" },
  },
  event = "VeryLazy",
  opts = {
    delay = function(ctx)
      return mapdelay[ctx.mode][ctx.keys] or ctx.plugin and 0 or 200
    end,
    preset = "modern",
    spec = global_mapping,
    notify = false,
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "s", mode = "n" },
    },
  },
}
