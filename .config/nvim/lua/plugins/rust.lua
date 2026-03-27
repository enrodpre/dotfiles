vim.g.rustfm_autosave = 1
vim.g.rustaceanvim = {
  executor_alias = "quickfix",
  tools = {
    executor = "quickfix",
    code_actions = {
      ui_select_fallback = true,
    },
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>ac", function()
        vim.cmd.RustLsp("codeAction")
      end, { desc = "Code Action", buffer = bufnr, silent = true })
      vim.keymap.set("n", "\\r", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })
      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<leader>fr", function()
        require("library.pickers").recursive_completions("RustLsp")
      end, {
        desc = "[F]ind [C]ommand for [RustLsp]",
        silent = true,
        buffer = bufnr,
      })
    end,
    -- default_settings = {
    --   -- rust-analyzer language server configuration
    --   ["rust-analyzer"] = {
    --     cargo = {
    --       features = "all",
    --     },
    --   },
    -- },
  },
}
return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rust", "toml" })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    enabled = true,
    ft = { "rust" },
    lazy = false,
  },
}
