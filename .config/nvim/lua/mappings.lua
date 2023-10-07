local M = {}

M.n = {
  [",i"] = { "i_<Esc>r", "Insert one caracter" },
  [",a"] = { "a_<Esc>r", "Append one caracter" },
  ["<C-o>"] = { "a<CR><Esc>", "Insert new line in normal mode" },
  ["oo"] = { "o<Esc>k", "Newline forward without entering insert mode" },
  ["OO"] = { "0i<CR><Esc>", "Newline forward without entering insert mode" },
  ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Opens declaration" },
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Opens definition" },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover action" },
  ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
  ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
  ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goes to implementation" },
  ["gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Opens type definition" },
  ["<leader>gw"] = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbol" },
  ["<leader>gW"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace symbol" },
  ["<leader>ae"] = { "<cmd>vim.diagnostic.open_float()<CR>", "Open float" },
  ["<leader>ar"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  ["<leader>ff"] = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format" },
  ["<leader>ai"] = { "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "Get incoming calls" },
  ["<leader>ao"] = { "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "Get outcoming calls" }
}

-- M.i = {
-- ["C-k"] = { "<BS>", "Put backspace" },
-- ["C-j"] = { "<CR>", "Put enter" },
-- }

M.v = {
  e = { 'y:!<C-r>"<CR>', "Execute selected text in a terminal" },
  f = { 'y/<C-r>"<CR>', "Find references in file" },
}


M[""] = {
  -- ["<leader>q"] = { ":q <CR>", "Quit" },
  ["<leader>qq"] = { ":q! <CR>", "Force quit" },
  ["<leader>ww"] = { ":w <CR>", "Save" },
  ["<leader>wq"] = { ":wq <CR>", "Save and quit" },
}

local loader = {}

function loader.load()
  for mode, mapping in pairs(M) do
    for shortcut, described_action in pairs(mapping) do
      local action, desc = unpack(described_action)
      vim.keymap.set(mode, shortcut, action, { desc = desc })
    end
  end
end

return loader
