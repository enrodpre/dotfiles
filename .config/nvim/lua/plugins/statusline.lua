local function lsp_status()
  local count_clients = function()
    local bufnr = vim.api.nvim_get_current_buf()
    return #vim.lsp.get_clients { bufnr = bufnr }
  end
  return {
    function()
      return
          " " .. count_clients()
    end,
    cond = function()
      return count_clients() > 0
    end
  }
end

local function default_sections()
  return {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          if not package.loaded["submode"] then
            return str
          end

          local ok, submode = pcall(require, "submode")
          if ok and submode.mode() ~= nil and submode.mode() ~= "" then
            return submode.mode():upper()
          end
          return str
        end,
      },
      {
        function()
          return "Recording @" .. vim.fn.reg_recording()
        end,
        cond = function()
          return vim.fn.reg_recording() ~= ""
        end,
      },
    },
    lualine_b = {
      "filename",
    },
    lualine_c = {
      "diagnostics",
    },
    lualine_x = {
      "%S",
      "filesize",
      "filetype",
      lsp_status(),
      {
        function()
          return "venv-selector"
        end,
        cond = function()
          return vim.bo.filetype == "python"
        end,
      },
    },
    lualine_y = {
      "searchcount",
      "selectioncount",
    },
    lualine_z = {
      "location",
      "progress",
    },
  }
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "UiEnter",
  opts = {
    extensions = {
      "lazy",
      "nvim-dap-ui",
      "quickfix",
      "trouble",
      "overseer",
      "man",
      "aerial",
      "fzf",
      -- require("library.terminal").statusline,
    },
    options = {
      theme = vim.g.colorscheme,
      globalstatus = vim.o.laststatus == 3,
      -- disabled_filetypes = { statusline = { "snacks_terminal" } },
      component_separators = "",
    },
    sections = default_sections(),
  },
}
