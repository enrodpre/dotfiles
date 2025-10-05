local left = "<C-S-h>"
local right = "<C-S-l>"
local down = "<C-S-j>"
local up = "<C-S-k>"

return
{
  "echasnovski/mini.move",
  keys = { left, right, down, up },
  opts = {
    mappings = {
      left = left,
      right = right,
      down = down,
      up = up,

      line_left = left,
      line_right = right,
      line_down = down,
      line_up = up,
    },
  },
}
