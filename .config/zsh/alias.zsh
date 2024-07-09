#!/bin/zsh

alias -g dots='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotsreload='dots rm -r --cached $HOME; dots add $HOME; dots status'
alias icat="kitty +kitten icat"
alias visudo='EDITOR=nvim visudo'

#Paru utils
alias pquery='paru -Q --info'

#Replaces
alias cat='bat'
alias rm='rip'
alias tree='eza -aT'
alias ls='eza -a'
alias l='eza -lbaa --color=auto'
alias llg='eza -lB@aa --git'
alias top='btop'
alias mv='mv -i'
alias rg='rg -p'
# alias du="du -h"
# alias df="df -h"
alias luarocks='luarocks --lua-version 5.1'

#Globals for the lazy
alias -g noerr='2> /dev/null'

# HELP
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

# Changing dirs easily
alias d='dirs -v'
for i in $(seq 9); do alias "$i"="cd +${i}"; done
unset i
