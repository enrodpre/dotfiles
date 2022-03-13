#!/bin/bash

alias zshconfig="nvim ~/.zshrc"
alias nvimconfig='nvim ~/.config/nvim/init.vim'
alias i3config='nvim ~/.config/i3/config'

alias tuxguitar='JAVA_HOME=/usr/lib/jvm/java-11-openjdk tuxguitar'

alias rlzsh="source ~/.zshrc"
alias clearswap='rm -f ~/.local/share/nvim/swap/*'

alias project="cd $CURRENT_PROJECT"
alias du="du -h"

alias luamake=/tmp/lua-language-server/3rd/luamake/luamake
alias cheat="cht.sh"
alias ls="exa -h"
alias lsa="exa -lah"
alias debugzsh="zsh -x ~/.zshrc"

alias dtf='git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME"' 
alias gitignoreall='echo "/*" > .gitignore'
