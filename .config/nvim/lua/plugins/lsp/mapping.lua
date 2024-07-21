#!/usr/bin/lua

local tb = lazyreq("telescope.builtin")

return {
  {
    "gdd",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "[G]o [D]ocument [D]iagnostics",
  },
  {
    "<leader>ac",
    function()
      vim.lsp.buf.code_action({ apply = true })
    end,
    desc = "[A]pply [C]ode Action",
  },
  {
    "gds",
    tb.lsp_document_symbols,
    desc = "[G]o [D]ocument [S]ymbols",
  },
  {
    "<leader>rr",
    vim.lsp.buf.rename,
    desc = "[R]ename",
  },
  {
    "<leader>re",
    function()
      require("telescope").extensions.refactoring.refactors()
    end,
    desc = "[R]efactor",
    mode = { "n", "x" },
  },
  {
    "<leader>rpp",
    function()
      require("refactoring").debug.printf({ below = false })
    end,
    desc = "[P]rintf",
  },
  {
    "<leader>rpb",
    function()
      require("refactoring").debug.printf({ below = true })
    end,
    desc = "[P]rintf [Below]",
  },
  {
    "<leader>rv",
    function(...)
      lazyreq("refactoring").debug.print_var(...)
    end,
    desc = "Print [V]ar",
    mode = { "x", "n" },
  },
  {
    "<leader>rc",
    function(...)
      require("refactoring").debug.cleanup(...)
    end,
    desc = "[C]leanup",
  },
  {
    "<leader>od",
    vim.diagnostic.open_float,
    desc = "[O]pen Dianostic",
  },
  -- {
  --   '<leader>oi',
  --   vim.lsp.buf.incoming_calls,
  --   desc = '[O]pen incoming calls',
  -- },
  -- {
  --   '<leader>oo',
  --   vim.lsp.buf.outgoing_calls,
  --   desc = '[O]pen outcoming calls',
  -- },
  {
    "<leader>os",
    vim.lsp.buf.signature_help,
    desc = "[O]pen [S]ignature",
  },
  {
    "<leader>wd",
    "lsp",
    desc = "[W]orkspace [D]iagnostics",
  },
  {
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    desc = "[W]orkspace [A]dd Folder",
  },
  {
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    desc = "[W]orkspace [R]emove Folder",
  },
  {
    "<leader>wl",
    function()
      vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "[W]orkspace [L]ist Folders",
  },
  {
    "<leader>ws",
    tb.lsp_dynamic_workspace_symbols,
    desc = "[W]orkspace [S]ymbols",
  },
  {
    "glD",
    vim.lsp.buf.declaration,
    desc = "[G]oto [D]eclaration",
  },
  {
    "gld",
    tb.lsp_definitions,
    desc = "[G]oto [D]efinition",
  },
  {
    "glr",
    tb.lsp_references,
    desc = "[G]oto [R]eferences",
  },
  {
    "gli",
    tb.lsp_implementations,
    desc = "[G]oto [I]mplementation",
  },
}
