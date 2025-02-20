#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

CONFIG=$XDG_CONFIG_HOME

#Config location overrides
export RIPGREP_CONFIG_PATH=$CONFIG/ripgreprc
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
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export M2_HOME="$XDG_DATA_HOME/m2"

# ccache
export CXX="ccache g++"

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
export GRAVEYARD=/tmp/graveyard

export PYTHONPATH=$XDG_DATA_HOME/python/functions:$HOME/.local/bin

export WORDLISTS=$XDG_DATA_HOME/seclists/

export DEVDIR=$HOME/dev
export HISTSIZE=10000
export SAVEHIST=10000

export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;/home/kike/.luarocks/share/lua/5.1/?.lua;/home/kike/.luarocks/share/lua/5.1/?/init.lua;/home/kike/.local/share/lua/5.1/?.lua;/home/kike/.local/share/lua/5.1/?/init.lua'
export LUA_CPATH='/home/kike/.local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/kike/.luarocks/lib/lua/5.1/?.so;/home/kike/.local/lib/lua/5.1/?.so'
export PATH='/home/kike/.local/pythonz/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/kike/.local/bin:/home/kike/.local/share/cargo/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/kike/.local/share/zsh/plugins/0-colors/bin'

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"

#Add custom functions
source $ZDOTDIR/functions.zsh

source "$ZDOTDIR/alias.zsh"

export GTEST_COLOR=1
