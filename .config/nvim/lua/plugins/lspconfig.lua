local mapping = {

  { "<leader>l", group = "[L]sp", },
  {
    "<leader>lr",
    function()
      require('trouble').open("lsp_references")
    end,
    desc = "[L]sp [R]eferences",
  },
  {
    "<leader>ls",
    vim.lsp.buf.signature_help,
    desc = "[L]sp [S]ignature",
  },
  {
    "<leader>ld",
    function()
      require("trouble").toggle("diagnostics_preview")
    end,
    desc = "[L]azy [D]iagnostics",
  },
  {
    "<leader>oo",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "[O]pen [O]utline",
  },
  {
    "<leader>rr",
    vim.lsp.buf.rename,
    desc = "[R]ename",
    silent = true,
    noremap = true,
  },
  {
    "<leader>od",
    vim.diagnostic.open_float,
    desc = "[O]pen Dianostic",
  },
}


return {
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    keys = mapping,
    opts = {
      tombi = {},
      bashls = { filetypes = { "zsh" } },
      asm_lsp = {},
      jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
      },
      yamlls = {},
    },
    config = function(_, opts)
      vim.diagnostic.config({
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      })
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(
          vim.lsp.protocol.make_client_capabilities(),
          true
        ),
      })

      for server, conf in pairs(opts) do
        vim.lsp.config(server, conf)
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      ---group = "[X] Trouble",
    },
    opts = {
      focus = true,
      keys = {
        ["<c-p>"] = "prev",
        ["<c-n>"] = "next",
      },
      modes = {
        diagnostics_preview = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
  }
}
