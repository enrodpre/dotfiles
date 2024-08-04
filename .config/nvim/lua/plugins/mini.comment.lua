#!/usr/bin/lua

return {
  "echasnovski/mini.comment",
  event = "LspAttach",
  opts = {
    mappings = {
      comment = "<leader>c",
      comment_line = "<leader>cc",
      comment_visual = "<leader>c",
      textobject = "<leader>c",
    },
  },
}
