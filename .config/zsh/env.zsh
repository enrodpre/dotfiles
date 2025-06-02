#!/usr/bin/zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTCACHE=$XDG_CACHE_HOME/zsh
export ZSH_COMPDUMP=$ZDOTCACHE/zcompdump

#Config location overrides
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
export PYTHONSTARTUP="$HOME"/.config/python/pythonrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_CONFIG_HOME"/Xauthority
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export M2_HOME="$XDG_DATA_HOME"/m2
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

# ccache
export CXX="ccache g++"
export PYTHONPATH=$XDG_DATA_HOME/python/functions:$HOME/.local/bin:/bin/python

export LUA_PATH='/usr/share/lua/5.1/?.lua;./?.lua;./?/init.lua;'
export LUA_CPATH='$HOME/.local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;./?.so;$HOME/.local/lib/lua/5.1/?.so'
export PATH=${PATH}:'/usr/local/sbin:/usr/local/bin:/usr/bin:$HOME/.local/bin:$CARGO_HOME/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/share/zsh/plugins/0-colors/bin'}

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
