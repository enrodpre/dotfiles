return {
  "smoka7/multicursors.nvim",
  enabled = false,
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
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", },
  keys = {
    {
      mode = { "v", "n", },
      "<Leader>ms",
      "<cmd>MCstart<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
    {
      mode = { "v", "n", },
      "<Leader>mv",
      "<cmd>MCvisual<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
    {
      mode = { "v", "n", },
      "<Leader>mp",
      "<cmd>MCpattern<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
    {
      mode = { "v", "n", },
      "<Leader>mc",
      "<cmd>MCclear<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
  },
}
