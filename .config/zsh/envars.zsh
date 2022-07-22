#!/usr/bin/zsh

export ZDOTDIR=$HOME/.config/zsh
export EDITOR=nvim

path+=(
  $HOME/.local/bin
  /opt/pycharm-community-2021.3.3/bin
)

fpath+=(
  $HOME/.zsh/bin/
  $fpath
)

autoload $ZSH/bin/*

export -U PATH
export -U FPATH
export -U PYTHON_PATH=$HOME/.local/share/python
export -U LUA_PATH=$HOME/.local/share/lua/\?.lua
