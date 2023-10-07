local opts = {}

opts.servers = {
  lua_ls = {
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  bashls = {
    filetypes = {
      "sh",
      "zsh",
      "bash",
    }
  },
  ruff_lsp = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
  vimls = {},
}

local lsp = {
  "neovim/nvim-lspconfig",
  config = function()
    local lsp_configs = require("lspconfig")
    -- local lsp_defaults = lsp_configs.util.default_config
    local servers = opts.servers

    -- lsp_defaults.capabilities = vim.tbl_deep_extend(
    --   'force',
    --   lsp_defaults.capabilities,
    --   require('cmp_nvim_lsp').default_capabilities()
    -- )

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    for server, opt in pairs(servers) do
      lsp_configs[server].setup(
        vim.tbl_deep_extend("force", capabilities, opt)
      )
    end
  end,
  dependencies = {
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  event = { "BufReadPre", "BufNewFile" }
}

return lsp
