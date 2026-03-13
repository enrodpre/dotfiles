#!/usr/bin/zsh

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
  exec systemd-cat --identifier=sway sway
fi

bindkey -e

########### SHELL VARS ############
export EZA_COLORS="$(cat $ZDOTDIR/themes/eza)"
export HISTFILE=$XDG_STATE_HOME/.zsh_history
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

# # Share history between terminal sessions
# setopt SHARE_HISTORY

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# Themes
source $ZDOTDIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source $ZDOTDIR/alias.zsh

# Source plugins
fd -L -t f -d 2 ".plugin.zsh" "$XDG_DATA_HOME/zsh/autoload" | while read -r zshplugin; do source $zshplugin; done

typeset mods=(
    zsh/complist
    zsh/nearcolor
    zsh/zprof
)

for module in "${mods[@]}"; do
    zmodload "$module"
done

# autoload -Uz vcs_info

# Load scripts
typeset -U fpath

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

source $ZDOTDIR/completion.zsh

if [ -z $NVIM ]; then
    source $ZDOTDIR/standalone.zsh
else
    source $ZDOTDIR/embedded.zsh
fi

source $ZDOTDIR/mapping.zsh
