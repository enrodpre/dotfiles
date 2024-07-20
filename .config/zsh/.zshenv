#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

CONFIG=$XDG_CONFIG_HOME

export ZDOTDIR=$CONFIG/zsh
export ZDOTCACHE=$XDG_CACHE_HOME/zsh
export ZSH_COMPDUMP=$ZDOTCACHE/zcompdump
export KITTY_ORIG_ZDOTDIR=$ZDOTDIR
export BAT_CONFIG_PATH="$CONFIG/bat/config"
export NPM_CONFIG_USERCONFIG=$CONFIG/npmrc
export GITIGNORE_DIR=$XDG_DATA_HOME/gitignore
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
export VISUAL='nvim'

export SHELL='zsh'
export PYTHONZ_ROOT=$HOME/.local/pythonz

export EZA_COLORS="$(cat $ZDOTDIR/themes/eza)"

export PYTHONPATH=$XDG_DATA_HOME/python/functions:$HOME/.local/bin
export LUA_PATH='/home/kike/.local/share/lua/5.1/?.lua;/home/kike/.local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/home/kike/.local/share/lua/?.lua;/home/kike/.local/share/lua/5.1/?/?.lua;/usr/share/lua/5.1/?/init.lua;/home/kike/.local/share/lua/**;/home/kike/coding/nvim/plugins/?.nvim/lua/?.lua'
export LUA_CPATH='/home/kike/.local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so'

export WORDLISTS=$XDG_DATA_HOME/seclists/

export HISTFILE=$ZDOTCACHE/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH_ASK_API_KEY="(cat $ZDOTDIR/.chatgpt.key)"

#Add custom functions
source $ZDOTDIR/functions.zsh

source "$ZDOTDIR/alias.zsh"
