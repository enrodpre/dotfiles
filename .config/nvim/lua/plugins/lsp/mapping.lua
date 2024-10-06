#!/usr/bin/lua

local tb = lazyreq("telescope.builtin")

local erase_word = function(find)
  local current_line = vim.api.nvim_get_current_line()
  local new_line = current_line:gsub(find, "")
  vim.api.nvim_set_current_line(new_line)
end

local surround_word = function(surr)
  local left = surr.left or ""
  local right = surr.right or ""

  local current_word = vim.fn.expand("<cWORD>")
  local new_word = left .. current_word .. right
  local current_line = vim.api.nvim_get_current_line()
  local new_line = current_line:gsub(current_word, new_word)

  vim.api.nvim_set_current_line(new_line)
end

vim.api.nvim_create_augroup("ft_mapping", { clear = true })

local create_au_ft_mapping = function(c)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "ft_mapping",
    desc = c.desc,
    pattern = c.pattern,
    callback = function()
      local wk = require("which-key")
      for _, binding in ipairs(c.keys) do
        if not binding.group then
          binding.silent = true
          binding.noremap = true
        end
      end

      wk.add(c.keys)
    end,
  })
end

local is_ft = function(filetype)
  return vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf() }) == filetype
end

local C = {
  desc = "Some keybindings to ease cpp",
  pattern = "*.?pp",
  keys = {
    { "<leader>s", group = "[M]odify" },
    { "<leader>sa", group = "[A]dd" },
    { "<leader>sr", group = "[R]emove" },
    {
      "gdh",
      "<Cmd>ClangdSwitchSourceHeader<CR>",
      desc = "[G]oto [H]eader/source",
    },
    {
      "<leader>sao",
      function()
        surround_word({ left = "std::optional<", right = ">" })
      end,
      desc = "Add optional to cword",
    },
    {
      "<leader>sac",
      function()
        surround_word({ left = "const " })
      end,
      desc = "Add const to variable",
    },
    {
      "<leader>sar",
      function()
        surround_word({ right = "&" })
      end,
      desc = "Add reference to variable",
    },
    {
      "<leader>sab",
      function()
        surround_word({ left = "const ", right = "&" })
      end,
      desc = "Add const and reference to variable",
    },
    {
      "<leader>src",
      function()
        erase_word("const ")
      end,
      desc = "Remove const from variable",
    },
    {
      "<leader>srr",
      function()
        erase_word("&")
      end,
      desc = "Remove ref from variable",
    },
    {
      "<leader>srb",
      function()
        erase_word("const ")
        erase_word("&")
      end,
      desc = "Remove both ref and const",
    },

    {
      "<leader>scc",
      function()
        vim.lua.fn.cpp.constructor()
      end,
      desc = "Create a cpp constructor effortless",
      noremap = true,
      silent = true,
    },
  },
}

create_au_ft_mapping(C)

M = {
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
    tb.lsp_dynamic_workspace_symbols,
    desc = "[W]orkspace [S]ymbols",
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

return M
