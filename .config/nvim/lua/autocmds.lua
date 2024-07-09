vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", }, {
   pattern = "*",
   callback = function(args)
      if vim.t.bufs == nil then
         vim.t.bufs = { args.buf, }
      else
         local bufs = vim.t.bufs

         -- check for duplicates
         if not vim.tbl_contains(bufs, args.buf) and
            (args.event == "BufAdd" or vim.bo [args.buf].buflisted) then
            table.insert(bufs, args.buf)
            vim.t.bufs = bufs
         end
      end
   end,
})

vim.api.nvim_create_autocmd("BufDelete", {
   pattern = "*",
   callback = function(args)
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
         local bufs = vim.t [tab].bufks
         if bufs then
            for i, bufnr in ipairs(bufs) do
               if bufnr == args.buf then
                  table.remove(bufs, i)
                  vim.t [tab].bufs = bufs
                  break
               end
            end
         end
      end
   end,
})

vim.api.nvim_create_autocmd("BufUnload", {
   desc = "Last status succesful when unloading buffer",
   buffer = 0,
   callback = function() vim.opt.laststatus = 0 end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
   desc = "Sets shebang when creating a new file",
   pattern = "*.*",
   callback = function()
      local ext_to_binary = {
         awk = "awk",
         hs = "runhaskell",
         jl = "julia",
         lua = "lua",
         m = "octave",
         mak = "make",
         php = "php",
         pl = "perl",
         py = "python3",
         r = "Rscript",
         rb = "rubyoptions",
         scala = "scala",
         sh = "bash",
         tcl = "tclsh",
         tk = "wish",
      }

      local ext = vim.fn.expand("%:e")

      if ext == nil or ext == "" then return end

      local binary = ext_to_binary [ext]

      if binary == nil then return end

      local handle = io.popen("which " .. binary)
      local shebang
      if handle ~= nil then
         shebang = handle:read()
         handle:close()
      else
         shebang = "/usr/bin/env " .. binary
      end

      local parent_dir = vim.api.nvim_command("echo fnamemodify(getcwd(),':t')")

      if parent_dir == "bin" then
         vim.cmd [[ autocmd BufWritePost *.* :autocmd VimLeave * :!chmod u+x % ]]
         vim.cmd [[ f expand("%:r") ]]
      end

      vim.api.nvim_put({ "#!" .. shebang, }, "", true, true)
      vim.fn.append(1, "")
      vim.fn.append(1, "")
      vim.fn.cursor({ 3, 0, })
   end,
})

vim.api.nvim_create_autocmd("VimEnter", {
   desc = "Auto select virtualenv Nvim open",
   pattern = "*.py",
   callback = function()
      local _, err = pcall(require, "venv-selector")
      if err then return end
      local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
      print(venv)
      if venv ~= "" then require("venv-selector").retrieve_from_cache() end
   end,
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
   clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlights when yanking",
   callback = function() vim.highlight.on_yank() end,
   group = highlight_group,
   pattern = "*",
})


-- Log every type of filetype opened
vim.api.nvim_create_autocmd("FileType", {
   callback = function(event)
      local logfile = "filetypes.txt"
      local filepath = "/home/kike/.config/nvim/" .. logfile
      local comm = "grep -q " ..
         event.match .. " " .. filepath .. "|| echo " .. event.match .. " >> " ..
         filepath

      os.execute(comm)
   end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
   pattern = {
      "PlenaryTestPopup", "help", "lspinfo",
      "man", "notify", "qf", "query",
      "spectre_panel", "startuptime",
      "tsplayground", "neotest-output",
      "checkhealth", "neotest-summary",
      "neotest-output-panel",
   },
   callback = function(event)
      vim.bo [event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>",
         {
            buffer = event.buf,
            silent = true,
         })
   end,
})
