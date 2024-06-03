#!/usr/bin/lua

local metatables = require("util.lazy_require")
local tb = metatables.require_on_exported_call("telescope.builtin")
-- local provider = function() require("telescope.builtin") end

-- local K = metatables.default()
local K = {
   general = {},
   lsp = {},
   telescope = {},
   dap = {},
}

local dismiss_key_if_cmp = function(keymap)
   if not keymap then return end

   return function()
      vim.print(keymap)
      local loaded, cmp = pcall(require, "cmp")
      if not loaded then return end

      local is_cmp_visible = cmp.visible()
      if is_cmp_visible then return end

      local clean_keymap = vim.api.nvim_replace_termcodes(keymap, true, false,
         true)
      vim.api.nvim_feedkeys(clean_keymap, vim.fn.mode(), false)
   end
end

K.general = {
   ["<F4>"] = {
      ":<UP><CR>", "Execute last command",
   },
   ["<C-o>"] = {
      "a<CR><Esc>", "Append new line",
   },
   o = {
      name = "which_key_ignore",
   },
   oo = {
      "o<Esc>k",
      "Newline forward",
   },
   OO = {
      "0i<CR><Esc>", "Newline backwards",
   },
   ["<C-Q>"] = {
      ":q <CR>", "Quit neovim",
   },
   ["<C-Q><C-Q>"] = {
      ":q! <CR>", "Force quit",
   },
   ["<C-s>"] = {
      "<cmd>w<CR>",
      "Save",
   },
   e = {
      "y:!<C-r>\"<CR>",
      "Execute selected text in a terminal",
      mode = "v",
   },
}

local cmp_aware_keymaps = {
   "<Tab>", "<S-Tab>",
}

--[[ for _, keymap in ipairs(cmp_aware_keymaps) do
   K.general [keymap] = {
      dismiss_key_if_cmp(keymap),
      "override for" .. keymap,
      mode = { "i", "c", },
      noremap = false,
   }
end ]]

K.general ["<leader>"] = {
   e = {
      a = {
         function()
            local ft = vim.bo.filetype
            if ft == "python" then
               os.execute("autoimport " .. vim.fn.expand("%:S"))
               vim.cmd("e")
            end
         end,
         "[E]xecute [A]utoimport",
      },
      "[E]xecute",
   },
   h = {
      name = "Git [H]unk",
   },
}

K.lsp ["<leader>"] = {
   d = {
      name = "[D]ocument",
      a = {
         vim.lsp.buf.code_action,
         "[D]ocument [A]ctions",
      },
      d = {
         tb.diagnostics,
         "[D]ocument [D]iagnostics",
      },
      s = {
         name = "[D]ocument [S]ymbols",
         s = {
            tb.lsp_document_symbols,
            "[D]ocument [S]ymbols",
         },
         f = {
            function()
               tb.lsp_document_symbols({
                  symbols = "function",
               })
            end,
            "[D]ocument [S]ymbols [F]unctions",
         },
      },
   },
   r = {
      vim.lsp.buf.rename,
      "[R]ename",
   },
   s = {
      name = "[S]how",
      d = {
         vim.diagnostic.open_float,
         "[S]how Dianostic",
      },
      i = {
         vim.lsp.buf.incoming_calls,
         "[S]how incoming calls",
      },
      o = {
         vim.lsp.buf.outgoing_calls,
         "[S]how outcoming calls",
      },
      s = {
         vim.lsp.buf.signature_help,
         "[S]how [S]ignature",
      },
   },
   w = {
      name = "[W]orkspace",
      d = {
         "<cmd>TroubleToggle workspace_diagnostics<cr>",
         "[W]orkspace [D]iagnostics",
      },
      a = {
         vim.lsp.buf.add_workspace_folder,
         "[W]orkspace [A]dd Folder",
      },
      r = {
         vim.lsp.buf.remove_workspace_folder,
         "[W]orkspace [R]emove Folder",
      },
      l = {
         function()
            vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         "[W]orkspace [L]ist Folders",
      },
      s = {
         tb.lsp_dynamic_workspace_symbols,
         "[W]orkspace [S]ymbols",
      },
   },
}
--vim.print(vim.inspect(K.lsp))

K.lsp.g = {
   D = {
      vim.lsp.buf.declaration,
      "[G]oto [D]eclaration",
   },
   d = {
      tb.lsp_definitions,
      "[G]oto [D]efinition",
   },
   r = {
      tb.lsp_references,
      "[G]oto [R]eferences",
   },
   i = {
      tb.lsp_implementations,
      "[G]oto [I]mplementation",
   },
}

-- vim.print(K.lsp)

K.telescope ["<leader>"] = {
   f = {
      name = "[F]ind",
      ["?"] = {
         tb.oldfiles,
         "[?] Find recently opened files",
      },
      ["<leader>"] = {
         tb.buffers,
         "[ ] Find existing buffers",
      },
      ["/"] = {
         function()
            tb.current_buffer_fuzzy_find(require(
               "telescope.themes").get_dropdown {
               winblend = 10,
               previewer = false,
            })
         end,
         "[/] Fuzzily search in current buffer",
      },
      f = {
         tb.find_files,
         "[F]ind [F]iles",
      },
      g = {
         tb.live_grep,
         "[F]ind by [G]rep",
      },
      h = {
         tb.help_tags,
         "[F]ind help",
      },
      w = {
         tb.grep_string,
         "[F]ind current [W]ord",
      },
   },
   g = {
      name = "[G]it",
      f = {
         tb.git_files,
         "[G]it [F]iles",
      },
      g = {
         ":LiveGrepGitRoot<cr>",
         "Find by [G]rep on [G]it root",
      },
   },
   k = {
      tb.keymaps,
      "[K]eymaps",
   },
   i = {
      -- require("plugins.telescope.builtin").inspect,
      "[I]nspect (TODO)",
      mode = { "n", "x", },
   },
   r = {
      -- require("telescope").extensions.refactoring.refactors,
      "[R]efactor TODO",
      mode = { "n", "x", },
   },
   t = {
      name = "[T]elescope",
      b = {
         tb.builtin,
         "[T]elescope [B]uiltins",
      },
      r = {
         tb.resume,
         "[T]elescope [R]esume",
      },
   },
}


K.dap = function()
   local dap = require("dap")
   local dapui = require("dapui")

   return {
      ["<leader>"] = {
         b = {
            dap.toggle_breakpoint,
            "Debug: Toggle Breakpoint",
         },
         B = {
            function()
               dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
            end,
            "Debug: Set Breakpoint",
         },
         ["<F1>"] = {
            dap.step_into,
            "Debug: Step Into",
         },
         ["<F2>"] = {
            dap.step_out,
            "Debug: Step Out",
         },
         ["<F3>"] = {
            dap.step_over,
            "Debug: Step Over",
         },
         ["<F5>"] = {
            dap.continue,
            "Debug: Start/Continue",
         },
         ["<F7>"] = {
            dapui.toggle,
            "Debug: See last session result.",
         },
      },
   }
end

return K
