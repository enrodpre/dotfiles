---@tag lazy-require

---@brief [[
--- Lazy.nvim is a set of helper functions to make requiring modules easier.
---
--- Feel free to just copy and paste these functions out or just add as a
--- dependency for your plugin / configuration.
---
--- Hope you enjoy (and if you have other kinds of lazy loading you'd like to see,
--- feel free to submit some issues. Metatables can do many fun things).
---
--- Source:
--- - https://github.com/tjdevries/lazy-require.nvim
---
--- Support:
--- - https://github.com/sponsors/tjdevries
---
---@brief ]]
local lazy = {}

--- Require on index.
---
--- Will only require the module after the first index of a module.
--- Only works for modules that export a table.
lazy.on_index = function(path)
  return setmetatable({}, {
    __index = function(_, key)
      return require(path)[key]
    end,

    __newindex = function(_, key, value)
      require(path)[key] = value
    end,
  })
end

--- Requires only when you call the _module_ itself.
---
--- If you want to require an exported value from the module,
--- see instead |lazy.on_exported_call()|
lazy.on_module_call = function(path)
  return setmetatable({}, {
    __call = function(_, ...)
      return require(path)(...)
    end,
  })
end

--- Require when an exported method is called.
---
--- Creates a new function. Cannot be used to compare functions,
--- set new values, etc. Only useful for waiting to do the require until you actually
--- call the code.
---
--- <pre>
--- -- This is not loaded yet
--- local lazy_mod = lazy.on_exported_call('my_module')
--- local lazy_func = lazy_mod.exported_func
---
--- -- ... some time later
--- lazy_func(42)  -- <- Only loads the module now
---
--- </pre>
lazy.on_exported_call = function(path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(path)[k](...)
      end
    end,
  })
end

lazy.callback = function(fn, params)
  return function()
    fn(unpack(params))
  end
end

lazy.on_exported_callback = function()
  return function(path)
    return lazy.on_exported_call(path)
  end
end

return lazy
