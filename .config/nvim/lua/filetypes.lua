#!/usr/bin/lua

vim.filetype.add {
   extension = {
      rasi = "rasi",
   },
   pattern = {
      ["${HOME}/.config/i3/.*"] = "i3config",
      ["${HOME}/.config/kitty/*.conf"] = "kitty",
   },
}
