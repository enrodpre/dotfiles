#!/usr/bin/zsh

zle -R

# Themes
source $ZDOTDIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/vi-mode.zsh"


################ p10k ##############
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f $ZDOTDIR/p10k.zsh ]] || source "$ZDOTDIR/p10k.zsh"
####################################

# Source plugins
fd -L -t f -d 2 ".plugin.zsh" "$XDG_DATA_HOME/zsh/plugins" | while read -r zshplugin; do source $zshplugin; done

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

path+=("$HOME/.cargo/bin")
export PATH

# Load scripts
typeset -U fpath
scripts_folder=$ZDOTDIR/scripts

if [[ -z ${fpath[(r)$scripts_folder]} ]] ; then
    fpath=($scripts_folder $fpath)

    # Autoload every function substracting the extension
    autoload -Uz $scripts_folder/*(.N:t)
fi

[[ -s $HOME/.local/pythonz/etc/bashrc ]] && source $HOME/.local/pythonz/etc/bashrc

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

#Key bindings
source $ZDOTDIR/mapping.zsh
