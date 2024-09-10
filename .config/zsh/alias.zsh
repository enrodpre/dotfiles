#!/bin/zsh

alias 2hex="printf '%x\n'"
alias -g dots='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotsreload='dots rm -r --cached $HOME; dots add $HOME; dots status'
alias icat="kitty +kitten icat"
alias visudo='EDITOR=nvim visudo'

#Replaces
alias cat='bat'
alias rm='rip'
alias tree='eza -aT'
alias ls='eza -a'
alias l='eza -lXbaa --color=auto'
alias ll='eza -lbaa --color=auto'
alias llg='eza -lB@aa --git'
alias top='btop'
alias mv='mv -i'
alias ds='dots status'
alias rg='rg -p'
alias rgh='rg -p --hidden'
# alias du="du -h"
# alias df="df -h"
alias luarocks='luarocks --lua-version 5.1'

alias gdbdebug="./run -g && coredumpctl dump -o core && gdb built/standalone/CmmLang core"
# HELP
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

# Changing dirs easily
alias d='dirs -v'
for i in $(seq 9); do alias "$i"="cd +${i}"; done
unset i


# Project specific alias
CMMDIR="/home/kike/src/cmm"
alias -g currentcmm="$CMMDIR/build/standalone/current.cmm"
alias -g asmgen="$CMMDIR/build/"
