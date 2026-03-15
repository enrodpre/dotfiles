-- LuaRocks configuration

rocks_trees = {
  { name = "user", root = home .. ".local" },
  { name = "system", root = "/home/kike/.local" },
}
variables = {
  LUA_DIR = "/home/kike/.local",
  LUA_BINDIR = "/home/kike/.local/bin",
  LUA_VERSION = "5.1",
  LUA = "/home/kike/.local/bin/luajit",
}
