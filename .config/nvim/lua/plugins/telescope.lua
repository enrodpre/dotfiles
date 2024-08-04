return {
  "nvim-telescope/telescope.nvim",
  keys = {

    {
      "gf?",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "[?] Go receed files",
    },
    {
      "g<leader>",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      desc = "[F]uzzily search in current [B]uffer",
    },
    {
      "gff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "[G]o [F]ind [F]iles",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "[G]o [G]rep",
    },
    {
      "gh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "[G]o [H]elp",
    },
    {
      "<leader>fgw",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "[F]ind by [G]rep current [W]ord",
    },
    {
      "<leader>gf",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "[G]it [F]iles",
    },
    {
      "<leader>fgg",
      ":LiveGrepGitRoot<cr>",
      desc = "[F]ind by [G]rep on [G]it root",
    },
    {
      "<leader>ll",
      ":Telescope lazy<CR>",
      desc = "[L]azy",
    },
    {
      "<leader>lp",
      ":Telescope lazy_plugins<CR>",
      desc = "[P]lugins",
    },
    {
      "<leader>lc",
      function()
        require("telescope._extensions.content").exports.content()
      end,
      desc = "[C]ontent",
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "[T]elescope [B]uiltins",
    },
    {
      "<leader>tr",
      function()
        require("telescope.builtin").resume()
      end,
      desc = "[T]elescope [R]esume",
    },
    {
      "<leader>tc",
      ":Cheatsheet<CR>:",
      desc = "[T]elescope [C]heatsheet",
    },
    {
      "<leader>nn",
      function()
        require("plugins.telescope.pickers").choose_neogen()
      end,
      desc = "[N]eogen",
    },
  },
}
