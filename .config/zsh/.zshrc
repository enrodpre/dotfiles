#!/usr/bin/zsh

zle -R

# Themes
source $ZDOTDIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/vi-mode.zsh"

# Source plugins
fd -L -t f -d 2 ".plugin.zsh" "$XDG_DATA_HOME/zsh/plugins" | while read -r zshplugin; do source $zshplugin; done

################ p10k ##############
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f $ZDOTDIR/p10k.zsh ]] || source "$ZDOTDIR/p10k.zsh"
####################################

typeset mods=(
    zsh/complist
    zsh/mapfile
    zsh/nearcolor
    zsh/zleparameter
    zsh/zprof
    zsh/zselect
    zsh/net/tcp
)

for module in "${mods[@]}";
do
    zmodload "$module"
done

autoload -Uz add-zsh-hook vcs_info 

# Load scripts
typeset -U fpath
scripts_folder=$ZDOTDIR/scripts

if [[ -z ${fpath[(r)$scripts_folder]} ]] ; then
    fpath=($scripts_folder $fpath)

    # Autoload every function substracting the extension
    autoload -Uz $scripts_folder/*(.N:t)
fi


# Loads hooks
() {
    pushd "$ZDOTDIR/hooks" > /dev/null
    set -o shwordsplit

    EVENTS=("zshaddhistory")
    # "chpwd"

    for event in $EVENTS; do
        file=$event.zsh

        source $file

        funcnames $file |  while read fname; do
            add-zsh-hook $event $fname
        done
    done

    popd > /dev/null
}

# source <(luarocks completion bash)

[[ -s $HOME/.local/pythonz/etc/bashrc ]] && source $HOME/.local/pythonz/etc/bashrc

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

#Key bindings
source $ZDOTDIR/mapping.zsh
