#!/usr/bin/lua

local M = {
  ["K"] = { "Hover Documentation", "n", vim.lsp.buf.hover },
  ["gD"] = { '[G]oto [D]eclaration', "n", vim.lsp.buf.declaration },
  ["gd"] = { '[G]oto [D]efinition', "n", require('telescope.builtin').lsp_definitions },
  ["gr"] = { '[G]oto [R]eferences', "n", require('telescope.builtin').lsp_references },
  ['<leader>K'] = { "Signature help", "n", vim.lsp.buf.signature_help },
  ["gi"] = { '[G]oto [I]mplementation', "n", require('telescope.builtin').lsp_implementations },
  ["<leader>gw"] = { "Document symbol", "n", "<cmd>lua vim.lsp.buf.document_symbol()<CR>" },
  ["<leader>gW"] = { "Workspace symbol", "n", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" },
  ["<leader>ae"] = { "Open float", "n", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>" },
  ["<leader>rn"] = { '[R]e[n]ame', "n", vim.lsp.buf.rename },
  ["<leader>ca"] = { '[C]ode [A]ction', "n", vim.lsp.buf.code_action },
  ["<leader>ai"] = { "Get incoming calls", "n", vim.lsp.buf.incoming_calls },
  ["<leader>ao"] = { "Get outcoming calls", "n", vim.lsp.buf.outgoing_calls },
  ['<leader>D'] = { 'Type [D]efinition', "n", require('telescope.builtin').lsp_type_definitions, },
  ['<leader>ds'] = { '[D]ocument [S]ymbols', "n", require('telescope.builtin').lsp_document_symbols },
  ['<leader>Ws'] = { '[W]orkspace [S]ymbols', "n", require('telescope.builtin').lsp_dynamic_workspace_symbols },
  ['<leader>Wa'] = { '[W]orkspace [A]dd Folder', "n", vim.lsp.buf.add_workspace_folder },
  ['<leader>Wr'] = { '[W]orkspace [R]emove Folder', "n", vim.lsp.buf.remove_workspace_folder },
  ['<leader>Wl'] = { '[W]orkspace [L]ist Folders', "n", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end }
}


return vim.lua.loader(vim.lua.map, M)
