#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTCACHE=$XDG_CACHE_HOME/zsh
export ZSH_COMPDUMP=$ZDOTCACHE/zcompdump

export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgreprc
export GITIGNORE_DIR=$XDG_DATA_HOME/gitignore
export KITTY_ORIG_ZDOTDIR=$XDG_CONFIG_HOME
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME"/bat/config
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npmrc
export CONAN_HOME="$XDG_CONFIG_HOME"/conan2
export SANE_CONFIG_DIR="$XDG_CONFIG_HOME"/sane
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export M2_HOME="$XDG_DATA_HOME"/m2
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export GDBHISTFILE="$XDG_STATE_HOME/gdb_history"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export MAVEN_OPTS="-Dmaven.repo.local=$XDG_DATA_HOME/m2"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export TERM_EMULATOR=/usr/bin/kitty

# ccache
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONPATH=$XDG_DATA_HOME/python/functions:$HOME/.local/bin:/bin/python

#export LUA_PATH='/usr/share/lua/5.1/?.lua;./?.lua;./?/init.lua;'
#export LUA_CPATH='$HOME/.local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;./?.so;$HOME/.local/lib/lua/5.1/?.so'

path=(
  "$HOME"/.local/bin
  "$path[@]"
)

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"

source "$ZDOTDIR"/functions.zsh

# Theme vars
export FONT="Fira code"
typeset -U EXCLUDED_DIRS
EXCLUDED_DIRS=(/dev /proc /run /sys)
. "/home/kike/.local/share/cargo/env"
