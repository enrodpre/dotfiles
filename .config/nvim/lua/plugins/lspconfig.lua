local mapping = {
  {
    "gl",
    group = "[G]o [L]sp",
  },
  {
    "<leader>wd",
    "<cmd>Trouble diagnostics toggle<cr>",
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
    function(...)
      require("telescope").lsp_dynamic_workspace_symbols(...)
    end,
    desc = "[W]orkspace [S]ymbols",
  },
  {
    "<leader>rr",
    function(...)
      vim.lsp.buf.rename(...)
    end,
    desc = "[R]ename",
    silent = true,
    noremap = true,
  },
  {
    "gd",
    group = "[G]o [D]ocument",
  },
  {
    "gdd",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "[G]o [D]ocument [D]iagnostics",
  },
  {
    "<leader>ac",
    function()
      vim.lsp.buf.code_action({ apply = true, })
    end,
    desc = "[A]pply [C]ode Action",
  },
  {
    "<leader>od",
    vim.diagnostic.open_float,
    desc = "[O]pen Dianostic",
  },
  {
    "<leader>oi",
    vim.lsp.buf.incoming_calls,
    desc = "[O]pen incoming calls",
  },
  {
    "<leader>os",
    vim.lsp.buf.signature_help,
    desc = "[O]pen [S]ignature",
  },
}

local function init_format_on_save()
  local fos = vim.lsp.format_on_save
  if fos == nil then
    vim.lsp.format_on_save = {
      value = true,
      toggle = function(self)
        if self.value then self.value = false else self.value = true end
        vim.print("format_on_save = " .. tostring(self.value))
      end
    }
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    keys = mapping,
    opts = {
      tombi = {},
      bashls = { filetypes = { "zsh", }, },
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
        capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities(), true)
      })
      -- vim.lsp.config("*", {
      --   capabilities = {
      --     offsetEncoding = { "utf-16", },
      --     workspace = {
      --       fileOperations = {
      --         didRename = true,
      --         -- willRename = true,
      --       },
      --       didChangeWatchedFiles = {
      --         dynamicRegistration = true,
      --         relative_pattern_support = true,
      --       },
      --     },
      --   }
      -- })

      for server, conf in pairs(opts) do
        vim.lsp.config(server, conf)
        vim.lsp.enable(server)
      end


      vim.lsp.set_log_level("warn")
      init_format_on_save()
    end,
  },
}
