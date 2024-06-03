#!/usr/bin/lua


local go_up_cwd_find_files = function(prompt)
   local current_picker = require("telescope.actions.state").get_current_picker(
      prompt)
   -- cwd is only set if passed as telescope option
   local cwd = current_picker.cwd and tostring(current_picker.cwd) or
      vim.loop.cwd()
   local parent_dir = vim.fs.dirname(cwd)

   require("telescope.actions").close(prompt)
   require("telescope.builtin").find_files {
      prompt_title = parent_dir,
      cwd = parent_dir,
      hidden = true,
   }
end

return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "tsakirist/telescope-lazy.nvim",
   },
   event = "VeryLazy",
   opts = {
      default = {
         wrap_results = true,
      },
      pickers = {
         find_files = {
            mappings = {
               i = {
                  ["<C-u>"] = go_up_cwd_find_files,
                  ["<esc>"] = require("telescope.actions").close,
               },
            },
            prompt_title = vim.loop.cwd(),
         },
      },
      extension = require("plugins.telescope.extensions"),
   },
   config = function(opts)
      require("telescope").setup(opts)
      local telescope_mapping = require("keys").telescope
      require("which-key").register(telescope_mapping)
   end,
}
