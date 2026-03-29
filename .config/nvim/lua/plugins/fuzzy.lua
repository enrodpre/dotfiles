---@module "fzf-lua"
local fzflua = Lua.lazy.req("fzf-lua")

local function run_current_cwd(picker)
  return function()
    local cwd = vim.fn.expand("%:p:h")
    local cwd_opts = { cwd = cwd, prompt = cwd }
    picker(cwd_opts)
  end
end

local function run_with_cword(picker)
  return function()
    local cword = vim.fn.expand("<cWORD>")
    picker({ query = cword })
  end
end

local keymap = {
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
    "<leader>fF",
    run_with_cword(fzflua.files),
    desc = "[F]ind [F]iles with CWORD",
  },
  {
    "<leader>fc",
    group = "[F]ind in [C]wd",
  },
  {
    "<leader>fcf",
    run_current_cwd(fzflua.files),
    desc = "[F]ind Files in [C]wd",
  },
  {
    "<leader>fcg",
    run_current_cwd(fzflua.live_grep),
    desc = "[F]ind Grep in [C]wd",
  },
  {
    "<leader>fg",
    fzflua.live_grep,
    desc = "[F]ind [G]rep",
  },
  {
    "<leader>fG",
    run_with_cword(fzflua.live_grep),
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
  {
    "<leader>ac",
    function()
      require("fzf-lua.cmd").run_command("lsp_code_actions")
    end,
    desc = "[A]pply [C]ode Action",
  },
}

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    keys = keymap,
    event = "VeryLazy",
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
        grep = { follow = true },
      }
    end,
  },
  {
    "stephansama/fzf-nerdfont.nvim",
    cmd = "FzfNerdfont",
    keys = {
      {
        "<leader>pi",
        "<Cmd>FzfNerdfont<CR>",
        desc = "[P]ick [I]con",
      },
    },
    opts = {
      prompt = "Select Icon> ",
    },
  },
}
