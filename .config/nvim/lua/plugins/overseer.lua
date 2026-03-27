-- local constants = require("overseer.constants")


---@module "overseer"
local overseer = Lua.lazy.req("overseer")
local function run(cmd, components)
  overseer.new_task({ cmd = cmd, components = components }):start()
end

local function setup()
  local components = {
    { "open_quickfix" },
    { "unique",       replace = false },
    'default'
  }
  vim.api.nvim_create_user_command("Make", function(params)
    params.args = params.args or {}
    local args = vim.fn.expandcmd(params.args)
    local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)
    if num_subs == 0 then
      cmd = cmd .. " " .. args
    end
    run(cmd, { "compile" })
  end, {})
end

return {
  {
    enabled = false,
    'stevearc/overseer.nvim',
    opts = function()
      setup()
      return {
        templates = { "builtin", "cmake_gen", "make" },
        template_dirs = { "overseer.template", "overseer.template" },
        component_aliases = {
          compile = {
            { "display_duration",  detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
            { "on_output_quickfix" },
            "open_quickfix"
          },
        },
      }
    end,
  },
}
