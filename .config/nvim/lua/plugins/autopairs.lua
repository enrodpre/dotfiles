return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    enable_check_bracket_line = true,
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    local ts = require("nvim-autopairs.ts-conds")


    npairs.setup(opts)
    -- Add comma when table
    local trailling_comma_in_table = function(l, r)
      -- npairs.remove_rule(l)
      npairs.add_rule(
        Rule(l, r, "lua"):replace_endpair(function(opts)
          local put = vim.treesitter.get_node():type() == "table_constructor"
          if put then
            return r .. ","
          else
            return r
          end
        end) --ewith_pair(ts.is_ts_node())
      )
    end
    --trailling_comma_in_table("{", "}")
    --trailling_comma_in_table('"', '"')
    --

    local a
    for _, punct in pairs({ ",", ";" }) do
      npairs.add_rules({

        Rule("", punct)
            :with_move(function(o)
              return o.char == punct
            end)
            :with_pair(cond.none())
            :with_del(cond.none())
            :with_cr(cond.none())
            :use_key(punct)
      })
    end
    npairs.add_rules({
      Rule("{", "},", "lua"):with_pair(cond.not_after_text(",")):with_pair(ts.is_ts_node({ "table_constructor" })),
      Rule("'", "',", "lua"):with_pair(ts.is_ts_node({ "table_constructor" })),
      Rule('"', '",', "lua"):with_pair(ts.is_ts_node({ "table_constructor" })),
    })
    -- local get_closing_for_line = function(line)
    --   local i = -1
    --   local clo = ""
    --
    --   while true do
    --     i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
    --     if i == nil then
    --       break
    --     end
    --     local ch = string.sub(line, i, i)
    --     local st = string.sub(clo, 1, 1)
    --
    --     if ch == "{" then
    --       clo = "}" .. clo
    --     elseif ch == "}" then
    --       if st ~= "}" then
    --         return ""
    --       end
    --       clo = string.sub(clo, 2)
    --     elseif ch == "(" then
    --       clo = ")" .. clo
    --     elseif ch == ")" then
    --       if st ~= ")" then
    --         return ""
    --       end
    --       clo = string.sub(clo, 2)
    --     elseif ch == "[" then
    --       clo = "]" .. clo
    --     elseif ch == "]" then
    --       if st ~= "]" then
    --         return ""
    --       end
    --       clo = string.sub(clo, 2)
    --     end
    --   end
    --
    --   return clo
    -- end

    -- npairs.remove_rule("(")
    -- npairs.remove_rule("{")
    -- npairs.remove_rule("[")

    -- npairs.add_rule(Rule("[%(%{%[]", "")
    --   :use_regex(true)
    --   :replace_endpair(function(opt)
    --     return get_closing_for_line(opt.line)
    --   end)
    --   :end_wise(function(opt)
    --     -- Do not endwise if there is no closing
    --     return get_closing_for_line(opt.line) ~= ""
    --   end))
    -- Autopair on <> generics but not arithmetic
    -- npairs.add_rule(Rule("<", ">", {
    --   -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
    --   -- so that it doesn't conflict with nvim-ts-autotag
    --   "-html",
    --   "-javascriptreact",
    --   "-typescriptreact",
    -- }):with_pair(
    -- -- regex will make it so that it will auto-pair on
    -- -- `a<` but not `a <`
    -- -- The `:?:?` part makes it also
    -- -- work on Rust generics like `some_func::<T>()`
    --   cond.before_regex("%a+:?:?$", 3)
    -- ):with_move(function(opt)
    --   return opt.char == ">"
    -- end))
  end,
}
