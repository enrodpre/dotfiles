-- LuaRocks configuration

deploy_bin_dir = "/usr/bin"
deploy_lib_dir = "/usr/lib/lua/5.1"
deploy_lua_dir = "/usr/share/lua/5.1"
rocks_trees = {
   { name = "user", root = home .. "/.local" },
}
rocks_subdir = "/usr/lib/luarocks/rocks-5.1"
lua_interpreter = "luajit";
variables = {
   LUA_DIR = "/usr",
   LUA_INCDIR = "/usr/include/lua5.1",
   LUA_BINDIR = "/usr/bin",
   LUA_LIBDIR = "/usr/lib",
   RM = "rip",
}
web_browser = "firefox"
