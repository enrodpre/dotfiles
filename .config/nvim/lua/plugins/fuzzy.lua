local lazyreq = Lua.required_on_exported_call

---@module "fzf-lua"
local fzflua = lazyreq("fzf-lua")

local function cwd_picker(picker)
  local cwd = vim.fn.expand("%:p:h")
  -- local cwd_opts = { cwd = cwd, prompt = cwd }
  local cwd_opts = { cwd = cwd, prompt = cwd }
  return function()
    return picker(cwd_opts)
  end
end

-- replace builtin vim.ui.select
local function replace_select()
  -- vim.ui.select = setmetatable({}, {
  --   __call = function(args)
  --     local fzf = require("fzf-lua")
  --     fzf.register_ui_select()
  --     return vim.ui.select(table.unpack(args))
  --   end
  -- })
end

local function feed_input()
  vim.ui.input({ prompt = "Type a lua table to inspect" }, function(choice)
    vim.print(choice)
    require("fzf-lua").fzf_exec(_G[choice], {})
  end)
end

local function is_valid(obj)
  return vim.tbl_contains(_G, obj)
end

local function debug_object()
  local debug = require("library.debug")
  local cword = vim.fn.expand("<cword>")
  local obj
  local name
  if is_valid(cword) then
    obj = _G[cword]
    name = cword
  end
  local CWORD = vim.fn.expand("<CWORD>")
  if is_valid(CWORD) then
    obj = _G[CWORD]
    name = CWORD
  end
  debug.fuzzy_table(obj, name)
end

local function test_debug()
  local data = {
    "apple",
    b = "banana",
    aa = { "cherry", "date", { "elderberry", "fig", "grape" } },
    "kiwi",
  }
  local debug = require("library.debug")
  debug.fuzzy_table(data, "data")
end
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    init = replace_select,
    keys = {
      {
        "<leader>f",
        group = "[F]ind",
      },
      {
        "<leader>ff",
        fzflua.files,
        desc = "[F]ind [F]iles",
      },
      {
        "<leader>fc",
        cwd_picker(fzflua.files),
        desc = "[F]ind Files in [C]wd",
      },
      {
        "<leader>fg",
        fzflua.live_grep,
        desc = "[F]ind [G]rep",
      },
      {
        "<leader>fh",
        fzflua.help_tags,
        desc = "[F]ind [H]elp",
      },
      {
        "<leader>fb",
        fzflua.builtin,
        desc = "[F]ind [B]uiltins",
      },
      {
        "<leader>fk",
        fzflua.keymaps,
        desc = "[F]ind [K]eymaps",
      },
      {
        "grr",
        fzflua.lsp_references,
        desc = "[G]o to [R]eferences",
      },
      {
        "gri",
        fzflua.lsp_implementations,
        desc = "[G]o to [I]mplementations",
      },
      {
        "gra",
        fzflua.lsp_code_actions,
        desc = "[G]o to [A]ctions",
      },
      {
        "grd",
        fzflua.lsp_declarations,
        desc = "[G]o to [D]eclarations",
      },
      {
        "grD",
        fzflua.lsp_definitions,
        desc = "[G]o to [D]efinitions",
      },
      {
        "<leader>ft",
        debug_object,
        desc = "[G]o to [D]efinitions",
      },
      {
        "<leader>fd",
        test_debug,
        desc = "[G]o to [D]efinitions",
      },
    },
    opts = function()
      require("fzf-lua").register_ui_select()
      return {
        keymap = {
          fzf = {
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
            ["f3"] = "toggle-preview-wrap",
            ["f4"] = "toggle-preview",
            ["ctrl-f"] = "preview-page-down",
            ["ctrl-b"] = "preview-page-up",
          },
        },
        fzf_opts = { ["--cycle"] = true },
        fzf_colors = true,
      }
    end,
  },
  {
    "stephansama/fzf-nerdfont.nvim",
    cmd = "FzfNerdfont",
    keys = {
      {
        "<leader>fi",
        "<Cmd>FzfNerdfont<CR>",
        desc = "[F]ind [I]con",
      },
    },
    opts = {
      prompt = "Select Icon> ",
    },
  },
}
