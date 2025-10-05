local lazyreq = Lua.required_on_exported_call

---@module "fzf-lua"
local fzflua = lazyreq("fzf-lua")

local function cwd_picker(picker)
  local cwd = vim.fn.expand("%:p:h")
  -- local cwd_opts = { cwd = cwd, prompt = cwd }
  local cwd_opts = { cwd = cwd, prompt = "a", }
  return function() return picker(cwd_opts) end
end


-- replace builtin vim.ui.select
local function replace_select()
  vim.ui.select = setmetatable({}, {
    __call = function(args)
      local fzf = require("fzf-lua")
      fzf.register_ui_select()
      return vim.ui.select(table.unpack(args))
    end
  })
end


return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  init = replace_select,
  keys = {
    { "<leader>f",  group = "[F]ind", },
    { "<leader>ff", cwd_picker(fzflua.files),     desc = "[F]ind [F]iles", },
    { "<leader>fg", cwd_picker(fzflua.live_grep), desc = "[F]ind [G]rep", },
    { "<leader>fh", fzflua.help_tags,             desc = "[F]ind [H]elp", },
    { "<leader>fb", fzflua.builtin,               desc = "[F]ind [B]uiltins", },
    { "grr",        fzflua.lsp_references,        desc = "[G]o to [R]eferences" },
    { "gri",        fzflua.lsp_implementations,   desc = "[G]o to [I]mplementations" },
    { "gra",        fzflua.lsp_code_actions,      desc = "[G]o to [A]ctions" },
    { "grd",        fzflua.lsp_declarations,      desc = "[G]o to [D]eclarations" },
    { "grD",        fzflua.lsp_definitions,       desc = "[G]o to [D]efinitions" },
  },
  opts = function()
    return {
      keymap = {
        fzf = {
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",
          ["f3"]     = "toggle-preview-wrap",
          ["f4"]     = "toggle-preview",
          ["ctrl-f"] = "preview-page-down",
          ["ctrl-b"] = "preview-page-up",
        },
      },
      fzf_opts = { ['--cycle'] = true },
      fzf_colors = true
    }
  end,
}
