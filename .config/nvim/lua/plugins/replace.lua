return {
  "MagicDuck/grug-far.nvim",
  opts = function()
    local ret = {
      headerMaxWidth = 160,
      transient = true,
      startCursorRow = 4,
      startInInsertMode = false,

    }
    return ret
  end,
  keys = {
    {
      ",tc", function()
      local toggle_case = function(before)
        if before:find("[a-z][A-Z]") then
          -- Convert camelCase to snake_case
          local snake_case_word = before:gsub("([a-z])([A-Z])", "%1_%2"):lower()
          return snake_case_word
          -- Detect snake_case
        elseif before:find("_[a-z]") then
          local camel_case_word = before:gsub("(_)([a-z])",
                                              function(_, l) return l:upper() end)
          return camel_case_word
        else
          print("Not a snake_case or camelCase word")
        end
      end
      local ext
      if vim.bo.filetype == "cpp" then
        ext = "?pp"
      else
        ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      end
      local cword = vim.fn.expand("<cword>")
      require("grug-far").open {
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          replacement = string.format(" %s", toggle_case(cword)),
          search = string.format("(\\s)%s", cword),
        },
      }
    end,
    },
    {
      "<leader>or",
      function()
        local ext
        if vim.bo.filetype == "cpp" then
          ext = "?pp"
        else
          ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        end

        require("grug-far").open {
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            replacement = vim.fn.expand("<cword>"),
            search = vim.fn.expand("<cword>"),
          },
        }
      end,
      mode = { "n", "v", },
      desc = "Search and Replace",
    },
  },
}
