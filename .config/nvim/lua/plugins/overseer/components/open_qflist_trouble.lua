return {
  desc = "Open qflist trouble when failure",
  editable = false,
  constructor = function(params)
    return {
      on_exit = function(_, _, code)
        if code ~= 0 then
          require("trouble").open("qflist")
        end
      end
    }
  end
}
