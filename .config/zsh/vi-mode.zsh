#!/usr/bin/env zsh

ZVM_INIT_MODE=sourcing
source $XDG_DATA_HOME/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_INIT_MODE=sourcing

ZVM_VI_INSERT_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
ZVM_VI_SURROUND_BINDKEY=classic
ZVM_KEYTIMEOUT=0.4
ZVM_CURSOR_STYLE_ENABLED=true
