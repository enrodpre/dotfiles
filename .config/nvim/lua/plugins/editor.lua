local dial_map = vim.lua.lazyreq.on_exported_call("dial.map")
local lazyreq = vim.lua.lazyreq.on_exported_call

return {
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gx").setup({
        open_browser_app = "xdg-open",
        open_browser_args = {},
        handlers = {
          plugin = true,
          github = true,
          package_json = true, -- open dependencies from package.json
          search = true,
        },
        handler_options = {
          search_engine = "duckduckgo",
          select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
          git_remotes = { "upstream", "origin" },
          git_remote_push = false,
        },
      })
    end,
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {
      DEBUG_MODE = false,
      float_opts = {
        border = "none",
      },
      position = "top",
    },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>ms",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
      {
        mode = { "v", "n" },
        "<Leader>mv",
        "<cmd>MCvisual<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
      {
        mode = { "v", "n" },
        "<Leader>mp",
        "<cmd>MCpattern<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
      {
        mode = { "v", "n" },
        "<Leader>mc",
        "<cmd>MCclear<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "Vigemus/iron.nvim",
    lazy = true,
    config = function(_, opts)
      local iron = require("iron.core")
      iron.setup(opts)
    end,
    keys = {
      {
        "<leader>oc",
        "<cmd>IronRepl<CR>",
        desc = "[O]pen IronRepl [C]onsole",
      },
    },
    opts = {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          python = {
            command = { "python3" }, -- or { "ipython", "--no-autoindent" }
            lazyreq("iron.fts.common").bracketed_paste_python,
          },
        },
        repl_open_cmd = function()
          return require("iron.view").top("10%")
        end,
      },
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    },
  },
  {
    "folke/persistence.nvim",
    enabled=false,
    event = "BufReadPre",
    opts = {
      fast_wrap = {
        map = "",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      enable_check_bracket_line = false,
      check_ts = true,
      ts_config = {
        lua = { "string" },
        cpp = {},
      },
    },
    config = function(_, opts)
      --- Setup
      opts = opts or {}
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      --- custom rules
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
      npairs.add_rule(Rule("<", ">", {
        "-html",
        "-javascriptreact",
        "-typescriptreact",
      }):with_pair(
        -- regex will make it so that it will auto-pair on
        -- `a<` but not `a <`
        -- The `:?:?` part makes it also
        -- work on Rust generics like `some_func::<T>()`
        cond.before_regex("%a+:?:?$", 3)
      ):with_move(function(o)
        return o.char == ">"
      end))

      --- cmp integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          sh = false,
        })
      )
    end,
  },
  {
    "monaqa/dial.nvim",
    keys = function()
      local keys = {}

      local manipulate = dial_map.manipulate
      local data = {
        { "n", "<C-a>", "increment", "normal", "Increment <cword>" },
        { "n", "<C-x>", "decrement", "normal", "Decrement <cword>" },
        { "n", "g<C-a>", "increment", "gnormal", "Additive increment <cword>" },
        { "n", "g<C-x>", "decrement", "gnormal", "Additive decrement <cword>" },
        { "v", "<C-a>", "increment", "visual", "Increment <cword>" },
        { "v", "<C-x>", "decrement", "visual", "Decrement <cword>" },
        { "v", "g<C-a>", "increment", "gvisual", "Additive increment <cword>" },
        { "v", "g<C-x>", "decrement", "gvisual", "Additive decrement <cword>" },
      }

      for _, row in ipairs(data) do
        local mode, lhs, dir, rhs, desc = unpack(row)
        local key = {
          lhs,
          function()
            manipulate(dir, rhs)
          end,
          desc = desc,
          mode = mode,
        }

        table.insert(keys, key)
      end

      return keys
    end,

    config = function()
      local augend = require("dial.augend")

      local default_augend = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
      }

      local create_autogends = function(list, word)
        word = word or true
        for _, pair in ipairs(list) do
          table.insert(
            default_augend,
            augend.constant.new({
              elements = pair,
              preserve_case = true,
              word = true,
              cyclic = true,
            })
          )
        end
      end

      local new_augends = {
        {
          { "and", "or" },
          { "always", "never" },
          { "false", "true" },
          { "False", "True" },
          { "horizontal", "vertical" },
          { "yes", "no" },
        },
        {
          { "&", "|" },
          { "&&", "||" },
          { "+", "-" },
          { "==", "!=" },
        },
      }

      local words, tokens = unpack(new_augends)
      create_autogends(words)
      create_autogends(tokens, false)

      require("dial.config").augends:register_group({ default = default_augend })
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",

        line_left = "<C-h>",
        line_right = "<C-l>",
        line_down = "<C-j>",
        line_up = "<C-k>",
      },
    },
    config = true,
  },
  {
    "folke/ts-comments.nvim",
    event = "LazyFile",
    opts = {},
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 160,
    },
    keys = {
      {
        "<leader>or",
        function()
          local grug = require("grug-far")
          local ext
          if vim.bo.filetype == "cpp" then
            ext = "?pp"
          else
            ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          end
          grug.open({
            transient = true,
            startCursorRow = 4,
            startInInsertMode = false,
            preflls = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              replacement = vim.fn.expand("<cword>"),
              search = vim.fn.expand("<cword>"),
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
