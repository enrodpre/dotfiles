#!/usr/bin/zsh

zle -R

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# (cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.cache/wal/colors.sh

PLUGINS_PATH="$HOME/.local/lib/zsh/plugins/"

# Source plugins in /plugins
find $PLUGINS_PATH -maxdepth 1 -type d -not -name ".*" | while read plugin_dir; do find $plugin_dir -maxdepth 1 -type f -name "*.plugin.zsh" ; done | while read shplugin; do source $shplugin; done

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source "$ZDOTDIR/.p10k.zsh"

source $ZDOTDIR/functions.zsh

#Key bindings
bindkey -r "^J"
bindkey -r "^H"
bindkey -r "^K"
bindkey -r "^L"

bindkey '^R' history-incremental-search-backward

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

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook vcs_info edit-command-line insert-files
add-zsh-hook chpwd chpwd_recent_dirs

# Loads hooks
() {
    pushd "$ZDOTDIR/hooks" > /dev/null
    set -o shwordsplit

    EVENTS=("chpwd" "zshaddhistory")

    for event in $EVENTS; do
        file=$event.zsh

        source $file

        funcnames $file |  while read fname; do
            add-zsh-hook $event $fname
        done
    done

    popd > /dev/null
}

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# source <(luarocks completion bash)
zle_highlight=(region:standout special:standout
suffix:bold isearch:underline paste:standout)
