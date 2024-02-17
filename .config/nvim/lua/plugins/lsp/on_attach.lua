#!/usr/bin/lua

local M = {
   ["K"] = {
      "Hover Documentation", "n",
      vim.lsp.buf.hover,
   },
   ["<leader>K"] = {
      "Signature help", "n",
      vim.lsp.buf.signature_help,
   },
   ["gD"] = {
      "[G]oto [D]eclaration", "n",
      vim.lsp.buf.declaration,
   },
   ["gd"] = {
      "[G]oto [D]efinition", "n",
      require("telescope.builtin").lsp_definitions,
   },
   ["gr"] = {
      "[G]oto [R]eferences", "n",
      require("telescope.builtin").lsp_references,
   },
   ["gi"] = {
      "[G]oto [I]mplementation", "n",
      require("telescope.builtin").lsp_implementations,
   },
   ["<leader>f"] = {
      "Open floating diagnostic message", "n",
      vim.diagnostic.open_float,
   },
   ["<leader>rn"] = {
      "[R]e[n]ame", "n", vim.lsp.buf.rename,
   },
   ["<leader>al"] = {
      "[A]ctions [L]ist", "n",
      vim.lsp.buf.code_action,
   },
   ["<leader>aa"] = {
      "[A]ctions [A]utoimport", "n", function()
      local ft = vim.bo.filetype
      if ft == "python" then
         os.execute("autoimport " .. vim.fn.expand("%:S"))
         vim.cmd("e")
      end
   end,
   },

   ["<leader>dl"] = {
      "List Location (Trouble)", "n",
      "<cmd>TroubleToggle loclist<cr>",
   },

   ["<leader>dq"] = {
      "List Quickfix (Trouble)", "n",
      "<cmd>TroubleToggle quickfix<cr>",
   },

   ["<leader>li"] = {
      "Get incoming calls", "n",
      vim.lsp.buf.incoming_calls,
   },
   ["<leader>lo"] = {
      "Get outcoming calls", "n",
      vim.lsp.buf.outgoing_calls,
   },
   ["<leader>dd"] = {
      "[D]ocument [D]iagnostics", "n",
      "<cmd>TroubleToggle document_diagnostics<cr>",
   },
   ["<leader>ds"] = {
      "[D]ocument [S]ymbols", "n",
      require("telescope.builtin").lsp_document_symbols,
   },
   ["<leader>Ws"] = {
      "[W]orkspace [S]ymbols", "n",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
   },
   ["<leader>Wd"] = {
      "[W]orkspace [D]iagnostics", "n",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
   },
   ["<leader>Wa"] = {
      "[W]orkspace [A]dd Folder", "n",
      vim.lsp.buf.add_workspace_folder,
   },
   ["<leader>Wr"] = {
      "[W]orkspace [R]emove Fol der", "n",
      vim.lsp.buf.remove_workspace_folder,
   },
   ["<leader>Wl"] = {
      "[W]orkspace [L]ist Folders", "n",
      function()
         vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
   },
}


local on_attach= function(client, bufnr)
   vim.notify("attached")
   -- Create an autocmd that will run *before* we save the buffer.
   --  Run the formatting command for the LSP that has just attached.
   vim.api.nvim_create_autocmd("BufWritePre", {
      buf = bufnr,
      callback = function(info)
         vim.lsp.buf.format {
            async = false,
            -- filter = function(c) return c.id == client.id end,
         }
      end,
   })

   -- if vim.bo[bufnr].filetype == "python" then
   --    vim.api.nvim_create_autocmd("BufWritePost", {
   --       buffer = bufnr,
   --       callback = function()
   --          vim.g.eventignore =
   --             "BufWritePre,BufWritePost,BufReadPost,BufRead,BufReadPre,FileReadPost,FileReadPre"
   --
   --          os.execute("autoimport " .. vim.fn.expand("%:S"))
   --          vim.cmd[[ :e ]]
   --
   --          vim.g.ei = ""
   --          vim.cmd[[ :echo "hi" ]]
   --       end,
   --    })
   -- end

   vim.lua.map(M)
end

return on_attach
