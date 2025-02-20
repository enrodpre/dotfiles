return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    fast_wrap = {},
    enable_check_bracket_line = false,
    check_ts = true,
    ts_config = {
      lua = { "string", },
      cpp = {},
    },
  },
  config = function(_, opts)
    --- Setup
    opts = opts or {}
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    local npairs = require("nvim-autopairs")
    local ts = require("nvim-autopairs.ts-conds")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    npairs.setup(opts)

    --- custom rules
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

    -- lua -- add comma if brackets in table
    npairs.add_rule(Rule("{", "},", { "lua", }):with_pair(ts.is_ts_node(
      "table_constructor")))
    npairs.add_rule(Rule("\"", "\",", { "lua", }):with_pair(ts.is_ts_node(
      "table_constructor")))

    --- cmp integration
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done({
        sh = false,
      })
    )
  end,
}
