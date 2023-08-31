#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export CONFIG=$XDG_CONFIG_HOME

export ZDOTDIR=$CONFIG/zsh
export KITTY_ORIG_ZDOTDIR=$ZDOTDIR
export EDITOR=nvim
export SHELL=/usr/bin/zsh

export PYTHON_PATH=$XDG_DATA_HOME/python
export LUA_PATH=/home/kike/.local/share/lua/?.lua

# Add custom functions
fpath+=(
  $ZDOTDIR/functions
)
autoload -Uz $ZDOTDIR/functions/*(.:t)

source $ZDOTDIR/alias
