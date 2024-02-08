#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export CONFIG=$XDG_CONFIG_HOME

export ZDOTDIR=$CONFIG/zsh
export KITTY_ORIG_ZDOTDIR=$ZDOTDIR
export EDITOR='nvim'
export SUDO_EDITOR='nvim'

export SHELL='zsh'

export PYTHONPATH=$XDG_DATA_HOME/python/functions:$XDG_DATA_HOME/python/pytest-testconfig:$HOME/.local/bin
export LUA_PATH='/home/kike/.local/share/lua/5.1/?.lua;/home/kike/.local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/home/kike/.local/share/lua/?.lua;/home/kike/.local/share/lua/5.1/?/?.lua;/home/kike/.luarocks/share/lua/5.1/?.lua;/home/kike/.luarocks/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?/init.lua'
export LUA_CPATH='/home/kike/.local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/kike/.luarocks/lib/lua/5.1/?.so'

export WORDLISTS=$XDG_DATA_HOME/seclists/

export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH_ASK_API_KEY="(cat $ZDOTDIR/.chatgpt.key)"

# Add custom path
path+=(
    $HOME/.local/bin
    $HOME/.cargo/bin
)

# Add custom functions
typeset -U fpath
scripts_folder=$ZDOTDIR/scripts

if [[ -z ${fpath[(r)$scripts_folder]} ]] ; then
    fpath=($scripts_folder $fpath)

    # Autoload every function substracting the extension
    autoload -Uz $scripts_folder/*(.N:t)
fi

source "$ZDOTDIR/alias.zsh"
