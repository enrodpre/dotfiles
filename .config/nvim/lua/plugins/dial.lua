return {
  "monaqa/dial.nvim",
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

    local create_constant = function(list, opts)
      local word, case, cyclic = unpack(opts)
      for _, pair in ipairs(list) do
        table.insert(
          default_augend,
          augend.constant.new({
            elements = pair,
            preserve_case = case or true,
            word = word or true,
            cyclic = cyclic or true,
          })
        )
      end
    end

    local words = {
      { "and",        "or", },
      { "always",     "never", },
      { "false",      "true", },
      { "False",      "True", },
      { "horizontal", "vertical", },
      { "yes",        "no", },
      { "default",    "delete", },
      -- { "&",          "*", },
      { "&&",         "||", },
      { "+",          "-", },
      { "==",         "!=", },
    }

    local symbols = {
      -- { "&",  "*", },
      { "&&", "||", },
      { "+",  "-", },
      { "==", "!=", },
    }


    create_constant(words, { word = true })
    -- create_constant(symbols, { word = false })

    require("dial.config").augends:register_group({ default = default_augend, })
  end,

  keys = function()
    local keys = {}

    local data = {
      { "n", "<C-a>",  "increment", "normal",  "Increment <cword>", },
      { "n", "<C-x>",  "decrement", "normal",  "Decrement <cword>", },
      { "n", "g<C-a>", "increment", "gnormal", "Additive increment <cword>", },
      { "n", "g<C-x>", "decrement", "gnormal", "Additive decrement <cword>", },
      { "v", "<C-a>",  "increment", "visual",  "Increment <cword>", },
      { "v", "<C-x>",  "decrement", "visual",  "Decrement <cword>", },
      { "v", "g<C-a>", "increment", "gvisual", "Additive increment <cword>", },
      { "v", "g<C-x>", "decrement", "gvisual", "Additive decrement <cword>", },
    }

    for _, row in ipairs(data) do
      local mode, lhs, dir, rhs, desc = unpack(row)
      local key = {
        lhs,
        function()
          require("dial.map").manipulate(dir, rhs)
        end,
        desc = desc,
        mode = mode,
      }

      table.insert(keys, key)
    end

    return keys
  end,
}
