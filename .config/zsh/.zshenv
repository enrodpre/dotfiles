#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

CONFIG=$XDG_CONFIG_HOME

# Config location overrides
export ZDOTDIR=$CONFIG/zsh
export GITIGNORE_DIR=$XDG_DATA_HOME/gitignore
export KITTY_ORIG_ZDOTDIR=$ZDOTDIR
export BAT_CONFIG_PATH="$CONFIG/bat/config"
export NPM_CONFIG_USERCONFIG=$CONFIG/npmrc
export CONAN_HOME="$XDG_CONFIG_HOME/conan2"
export SANE_CONFIG_DIR="$XDG_CONFIG_HOME/sane"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export PYTHONSTARTUP="$HOME"/python/pythonrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XAUTHORITY="$XDG_CONFIG_HOME"/Xauthority

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

export ZSH_COMPDUMP=$ZDOTCACHE/zcompdump
export ZDOTCACHE=$XDG_CACHE_HOME/zsh
#export CPM_SOURCE_CACHE="$HOME/.cache/CPM"
export HISTFILE=$ZDOTCACHE/.zsh_history
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
export VISUAL='nvim'

export SHELL='zsh'
export PYTHONZ_ROOT=$HOME/.local/pythonz

export EZA_COLORS="$(cat $ZDOTDIR/themes/eza)"

export PYTHONPATH=$XDG_DATA_HOME/python/functions:$HOME/.local/bin

export WORDLISTS=$XDG_DATA_HOME/seclists/

export HISTSIZE=10000
export SAVEHIST=10000

path+=("$HOME/.local/bin" "$XDG_DATA_HOME"/cargo/bin)
export PATH

#Add custom functions
source $ZDOTDIR/functions.zsh

source "$ZDOTDIR/alias.zsh"

export CMMCURR="while"
