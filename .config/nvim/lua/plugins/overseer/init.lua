-- local constants = require("overseer.constants")

local function create_make()
  vim.api.nvim_create_user_command("Make", function(params)
    local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
    if num_subs == 0 then
      cmd = cmd .. " " .. params.args
    end
    local overseer = require("overseer")
    local task = overseer.new_task({
      cmd = vim.fn.expandcmd(cmd),
      components = {
        { "on_output_quickfix", open = params.bang,  open_height = 8 },
        { "open_output",        direction = "float", on_result = "if_diagnostics" },
        "default"
      },
    })

    task:start()
  end, {
    desc = "Run your makeprg as an Overseer task",
    nargs = "?",
    bang = true,
  })
end
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "CMakeLists.txt", "cmake", "CMakePresets.json" },
  callback = function()
    local overseer = require('overseer')
    overseer.run_template { name = "cmake_gen", function(task)
      vim.notify("run")
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }
        local main_win = vim.api.nvim_get_current_win()
        overseer.run_action(task, "open vsplit")
        vim.api.nvim_set_current_win(main_win)
      end
    end
    }
  end,
})


return {
  'stevearc/overseer.nvim',
  opts = {
    templates = { "builtin", "cmake_gen", "make" },
    template_dirs = { "overseer.template", "plugins.overseer.templates" },
    -- actions = {
    --   open_qflist_trouble = {
    --     desc = "Open trouble qflist if the task has result in failure",
    --     condition = function(task)
    --       return task.status == require("overseer.constants").STATUS.FAILURE
    --     end,
    --     run = function()
    --       vim.cmd("Trouble qflist")
    --     end
    --   },
    -- },
    -- task_list = {
    --   direction = "right",
    -- },
    component_aliases = {
      default = {
        { "display_duration",               detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        { "on_result_diagnostics_trouble",  close = true },
        { "on_result_diagnostics_quickfix", open = true },
        -- {
        --   constructor = function(params)
        --     return { on_exit = function(_, _, code) vim.print(code) end }
        --   end
        -- }
      }
    },
  },
  config = function(_, opts)
    create_make()
    require("overseer").setup(opts)
  end
}
