-- LuaRocks configuration

deploy_bin_dir = "$HOME/.local/bin"
deploy_lib_dir = "$HOME/.local/lib/lua/5.1"
deploy_lua_dir = "$HOME/.local/share/lua/5.1"
rocks_trees = {
   { name = "user", root = home .. "/.config/luarocks" },
}
rocks_subdir = "$HOME/.local/lib/luarocks/rocks-5.1"
lua_interpreter = "lua5.1";
variables = {
   LUA_BINDIR = "$HOME/.local/bin",
   LUA_DIR = "$HOME/.local",
   LUA_INCDIR = "$HOME/.local/include/lua5.1",
   LUA_LIBDIR = "$HOME/.local/lib",
   RM = "rip",
}
web_browser = "firefox"
