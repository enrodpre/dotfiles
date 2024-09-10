local F = {}

function F.put_text(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, "\n"), "\n")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

function F.get_selected_text()
  local visual = vim.fn.mode() == "v"

  if visual == true then
    local saved_reg = vim.fn.getreg("v")
    vim.cmd([[noautocmd sil norm! "vy]])
    local sele = vim.fn.getreg("v")
    vim.fn.setreg("v", saved_reg)
    return sele
  else
    return vim.fn.expand("<cWORD>")
  end
end

function F.get_selected(opts)
  local as = opts.as or "obj"
  local selected_text = F.get_selected_text()

  if as == "text" then
    return selected_text
  elseif as == "obj" then
    local loader, err = load("return " .. F.trim(selected_text))
    if loader then
      local obj = loader()
      return vim.inspect(obj)
    else
      print("error calling to func ", err)
    end
  else
    error("Bad assss")
  end
end

function F.fg(name)
  local hlgrp = vim.api.nvim_get_hl(0, {
    name = name,
  })
  return hlgrp and hlgrp.foreground
end

function F.currentdir()
  return vim.fn.expand("%:p:h")
end

function F.module_path(_module)
  local config_path = vim.fn.stdpath("config")
  local module_rel_path = _module:gsub("[.]", "/")

  return config_path .. "/lua/" .. module_rel_path
end

function F.ls(path, opts)
  opts = opts or {}
  local ext = opts.ext or false
  local init = opts.init or false

  local command = string.format("ls -1 %s", path)
  if not ext then
    command = command .. string.format(" | sed -e %s", "s/.lua$//")
  end

  if not init then
    command = command .. " | grep -v init"
  end

  local handle = io.popen(command)
  if not handle then
    return
  end
  local output = handle:lines()
  return output
end

function F.list_submodules(_module)
  local module_path = F.module_path(_module)
  return F.ls(module_path)
end

function F.load_submodules(_module)
  local submodules = {}
  for submodule_name in F.list_submodules(_module) do
    local ok, submodule = pcall(require, _module .. "." .. submodule_name)
    if not ok then
      vim.print("Error loading " .. submodule_name)
    end

    submodules[submodule_name] = submodule
  end

  return submodules
end

function F.get_icons(group) end

function F.ensure_execution(plugin_name, func)
  local lazy_cfg = require("lazy.core.config").plugins
  local plugin = lazy_cfg[plugin_name]
  if plugin and plugin._.loaded then
    func()
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == plugin_name then
          func()
          return true
        end
      end,
    })
  end
end

function F.lazy_load_extension(ext)
  return function()
    local load = function()
      require("telescope").load_extension(ext)
    end

    F.ensure_execution("telescope.nvim", load)
  end
end

---@param fn fun(client, buffer)
function F.on_attach(fn)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      fn(client, buffer)
    end,
  })
end

---@param name string
function F.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

local submodules = F.load_submodules("util.functions")
return vim.tbl_extend("force", F, submodules)
