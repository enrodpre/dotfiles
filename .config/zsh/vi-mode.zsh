#!/usr/bin/env zsh

function zvm_config() {
    ZVM_VI_INSERT_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
    # ZVM_VI_SURROUND_BINDKEY=classic
    ZVM_KEYTIMEOUT=0.4
    ZVM_CURSOR_STYLE_ENABLED=false
}
