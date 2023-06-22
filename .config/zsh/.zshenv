#!/bin/zsh

ZDOTDIR=~/.config/zsh
ZDOTENV="$ZDOTDIR"/.zshenv 

# Aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias reloadzsh="source $ZDOTENV && echo 'ZSH config reloaded from $ZDOTENV'"

alias -g tree='exa --tree -a'
alias -g ls='exa -a'
alias -g lsa='exa -lB@aa'

search() {
  grep "$1" -R "${2:-.}"
}

# source -- $ZDOTENV
