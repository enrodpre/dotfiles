#!/usr/bin/luaq

local load_mapping = function()
   vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
      {
         desc = "[?] Find recently opened files",
      })
   vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
      {
         desc = "[ ] Find existing buffers",
      })
   vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require(
         "telescope.themes").get_dropdown {
         winblend = 10,
         previewer = false,
      })
   end, {
      desc = "[/] Fuzzily search in current buffer",
   })

   -- vim.keymap.set("n", "<leader>s/", require("telescope.builtin").live_grep {
   --   grep_open_files = true,
   --   prompt_title = "Live Grep in Open Files"}, { desc = "[S]earch [/] in Open Files" })
   vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin,
      {
         desc = "[S]earch [S]elect Builtin",
      })
   vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files,
      { desc = "Search [G]it [F]iles", })
   vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files,
      { desc = "[S]earch [F]iles", })
   vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags,
      { desc = "[S]earch [H]elp", })
   vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string,
      {
         desc = "[S]earch current [W]ord",
      })
   vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep,
      { desc = "[S]earch by [G]rep", })
   vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>",
      {
         desc = "[S]earch by [G]rep on Git Root",
      })
   vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume,
      { desc = "[S]earch [R]esume", })
   vim.keymap.set("n", "<leader>k", require("telescope.builtin").keymaps,
      { desc = "See keymaps", })

   vim.keymap.set({ "n", "v", }, "<leader>i",
      require("plugins.telescope.builtin").inspect)

   vim.keymap.set({ "n", "x", }, "<leader>tr", function()
      require("telescope").extensions.refactoring.refactors()
   end)
end

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
   opts = {
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
      local telescope = require("telescope")

      telescope.setup(opts)

      load_mapping()
   end,
}
