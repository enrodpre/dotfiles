#!/bin/zsh

alias aliases="nvim ~/.config/zsh/alias.zsh"
alias gits="git status"
alias clip="wl-copy"
alias btop="btop --force-utf"
alias 2hex="printf '%x\n'"
alias dots='git --git-dir=$XDG_DATA_HOME/dotfiles/.git'
alias dotsreload='dots rm -r --cached $HOME; dots add $HOME; dots status'
alias ds='dots status'
alias icat="kitty +kitten icat"
alias visudo='EDITOR=nvim visudo'
alias reload='exec zsh'

alias coredebug='zsh -c "cd && coredumpctl debug"'
alias py='python'

local eza_default='--color=auto --icons --time-style=relative'
#Replaces
alias cat='bat'
alias rm='echo Usa rip'
alias tree='eza -aT'
alias ls='eza -a'
alias l='eza -la'
alias ll='eza -lbaa --color=auto'
alias llg='eza -lB@aa --git'
alias mv='mv -i'
alias rgh='rg --hidden'
# alias du="du -h"
# alias df="df -h"
alias luarocks='luarocks --lua-version 5.1'
alias pacman="sudo pacman"

alias adb='HOME="$XDG_DATA_HOME"/android adb'
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# HELP
autoload run-help
HELPDIR=/usr/share/zsh/"$ZSH_VERSION"/help
alias zhelp=run-help
