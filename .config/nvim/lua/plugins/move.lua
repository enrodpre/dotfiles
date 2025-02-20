local left = "<C-h>"
local right = "<C-l>"
local down = "<C-j>"
local up = "<C-k>"

return
{
  "echasnovski/mini.move",
  keys = { left, right, down, up },
  opts = {
    mappings = {
      left = left,
      right = right,
      down = left,
      up = up,

      line_left = left,
      line_right = right,
      line_down = down,
      line_up = up,
    },
  },
  config = true,
}
