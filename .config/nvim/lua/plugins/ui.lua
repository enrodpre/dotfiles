return {
  {
    "tpope/vim-sleuth",
    event = "UiEnter",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "UiEnter",
    opts = {
      "*",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "UiEnter",
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│", },
      scope = { enabled = false, },
      exclude = {
        filetypes = {
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = "UiEnter",
    opts = {
      symbol = "│",
      options = { try_as_border = true, },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    enabled = false,
    opts = {
      delay = 100,
      filetypes_denylist = {
        "lazy",
        "lazy_backdrop",
      },
      large_file_cutoff = 2000,
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
                         require("illuminate") ["goto_" .. dir .. "_reference"](false)
                       end,
                       {
                         desc = dir:sub(1, 1):upper() ..
                           dir:sub(2) .. " Reference",
                         buffer = buffer,
                       })
      end

      map("]]", "next")
      map("[[", "prev")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference", },
      { "[[", desc = "Prev Reference", },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim", }, })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim", }, })
        return vim.ui.input(...)
      end
    end,
  },
}
