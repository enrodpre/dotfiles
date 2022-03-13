#!/usr/bin/zsh

export EDITOR=nvim

path+=(
  $HOME/.local/bin
)

fpath+=(
  $HOME/.zsh/bin/
)

export -U PATH
export -U FPATH
export -U PYTHON_PATH=$HOME/.local/share/python
export -U LUA_PATH=$HOME/.local/share/lua/\?.lua
