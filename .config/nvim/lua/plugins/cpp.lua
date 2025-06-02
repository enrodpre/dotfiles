local patterns = {
  type = [[ [A-Za-z]+[A-Za-z(::)0-9_-]* ]],
  variable = [[[A-Za-z]+[A-Za-z0-9_-]*]],
}

local surroundings = {
  move = { "std::move(", ")", },
  optional = { "std::optional<", ">", },
}

local function toggle_reference_operator()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  if line:sub(col, col) == "." then
    vim.lua.replace_line("->", col, col)
  elseif col <= #line and line:sub(col, col + 1) == "->" then
    vim.lua.replace_line(".", col, col + 1)
  elseif col > 1 and line:sub(col - 1, col) == "->" then
    vim.lua.replace_line(".", col - 1, col)
  end
end


local local_mapping = {
  {
    ",n", desc = "[N]ode",
  },
  { ",np", desc = "[N]ode toggle dot <-> arrow",  toggle_reference_operator },
  {
    ",nm",
    function()
      vim.lua.surround_node(surroundings.move)
    end,
    desc = "[N]ode add std::move",
  },
  {
    ",no",
    function()
      vim.lua.surround_node(surroundings.optional)
    end,
    desc = "[N]ode add std::optional",
  },
  { ",nu", function() vim.lua.unfold_node {} end, desc = "[N]ode [U]nfold", },
  {
    "gdh",
    function()
      local file = vim.fn.expand('%:t')
      local filename = vim.fn.expand('%:t:r')
      local findcmd = { "fd", "-t", "f", "--color", "never", "--exclude", file, "-g", filename .. ".*" }
      local handle = io.popen(table.concat(findcmd, " "))
      local result = handle:read("*a")
      handle:close()

      local files = {}
      for f in result:gmatch("[^\r\n]+") do
        table.insert(files, f)
      end

      if #files == 1 then
        vim.cmd("e " .. files[1])
        return
      elseif #files == 0 then
        vim.print("No alternative files found")
        return
      end

      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values

      pickers.new({}, {
        prompt_title = "Find alt files of " .. file,
        finder = finders.new_oneshot_job(findcmd, {}),
        previewer = conf.grep_previewer({}),
        sorter = conf.file_sorter({}),
      }):find()
    end,
    desc = "[Go] to other compilation unit files",
  },
}

vim.api.nvim_create_autocmd("FileType", {
  desc = "Keymaps for cpp files",
  callback = function()
    local wk = require("which-key")
    wk.add(local_mapping)
  end,
})



return {
  {
    "p00f/clangd_extensions.nvim",
    -- event = "LspAttach",
    ft = "cpp",
    init = function()
      -- load clangd extensions when clangd attaches
      local augroup = vim.api.nvim_create_augroup("clangd_extensions",
        { clear = true, })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require("clangd_extensions")
            -- add more `clangd` setup here as needed such as loading autocmds
            vim.api.nvim_del_augroup_by_id(augroup) -- delete auto command since it only needs to happen once
          end
        end,
      })
    end,
    opts = {
      inlay_hints = {
        inline = true,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
  {
    "madskjeldgaard/cppman.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim", },
    },
    ft = "cpp",
    -- keys = {
    --   "<leader>ok",
    --   "<leader>fk",
    -- },
    config = function()
      local cppman = require("cppman")
      cppman.setup()

      -- Make a keymap to open the word under cursor in CPPman
      vim.keymap.set("n", "<leader>ok", function()
        cppman.open_cppman_for(vim.fn.expand("<cword>"))
      end)

      -- Open search box
      vim.keymap.set("n", "<leader>fk", function()
        cppman.input()
      end)
    end,
  },
}
