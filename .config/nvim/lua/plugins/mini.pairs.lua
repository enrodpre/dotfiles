#!/usr/bin/lua

return {
  "echasnovski/mini.pairs",
  enabled = true,
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    modes = { command = true, insert = true },
    mappings = {
      ["<"] = {
        action = "open",
        pair = "<>",
        neigh_pattern = "\r.",
        register = { cr = false },
      },
    },
  },
}
