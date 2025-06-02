#!/usr/bin/zsh

########### SHELL VARS ############
export EZA_COLORS="$(cat $ZDOTDIR/themes/eza)"
export HISTFILE=$ZDOTCACHE/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export GRAVEYARD="$XDG_STATE_HOME/graveyard"
export DEVDIR=$HOME/dev
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
export VISUAL='nvim'
export DOWNLOADSDIR="$XDG_DATA_HOME/downloads"
export GTEST_COLOR=1
###################################


alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# Themes
source $ZDOTDIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source $ZDOTDIR/functions.zsh
source $ZDOTDIR/alias.zsh


 ################ p10k ##############
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f $ZDOTDIR/p10k.zsh ]] || source "$ZDOTDIR/p10k.zsh"
####################################

# Source plugins
fd -L -t f -d 2 ".plugin.zsh" "$XDG_DATA_HOME/zsh/autoload" | while read -r zshplugin; do source $zshplugin; done

typeset mods=(
  zsh/complist
  zsh/nearcolor
  zsh/zprof
)

for module in "${mods[@]}";
do
    zmodload "$module"
done

autoload -Uz vcs_info

# Load scripts
typeset -U fpath
scripts_folder=$ZDOTDIR/scripts

if [[ -z ${fpath[(r)$scripts_folder]} ]] ; then
    fpath=($scripts_folder $fpath)

    # Autoload every function substracting the extension
    autoload -Uz $scripts_folder/*(.N:t)
fi


setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT


[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

source $ZDOTDIR/vi-mode.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/mapping.zsh
