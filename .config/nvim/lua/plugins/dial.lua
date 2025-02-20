return {
  "monaqa/dial.nvim",
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

  config = function()
    local augend = require("dial.augend")

    local default_augend = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias ["%Y/%m/%d"],
      augend.date.alias ["%Y-%m-%d"],
      augend.date.alias ["%m/%d"],
      augend.date.alias ["%H:%M"],
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
        { "and",        "or", },
        { "always",     "never", },
        { "false",      "true", },
        { "False",      "True", },
        { "horizontal", "vertical", },
        { "yes",        "no", },
        { "default",    "delete", },
        { "&",          "*", },
      },
      {
        { "&",  "*", },
        { "&&", "||", },
        { "+",  "-", },
        { "==", "!=", },
      },
    }

    local words, tokens = unpack(new_augends)
    create_autogends(words)
    create_autogends(tokens, false)

    require("dial.config").augends:register_group({ default = default_augend, })
  end,
}
