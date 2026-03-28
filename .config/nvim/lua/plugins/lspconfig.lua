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
    "<leader>rR",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "[R]ename File",
    silent = true,
    noremap = true,
  },
  {
    "<leader>od",
    vim.diagnostic.open_float,
    desc = "[O]pen Dianostic",
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local bufnr = ctx.buf
    local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end
})

vim.api.nvim_create_user_command("Toggle", function(args)
  -- if args.nargs < 1 then
  --   return
  -- end

  for _, opt in ipairs(args.fargs) do
    vim.g[opt] = not vim.g[opt]
    vim.print(string.format("%s option is now %s", opt, vim.g[opt]))
  end
end, {
  nargs = 1,
  complete = function()
    return { "autoformat" }
  end,
})

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      rename = { enabled = true },
      words = { enabled = true },
    }
  },
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    keys = mapping,
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
