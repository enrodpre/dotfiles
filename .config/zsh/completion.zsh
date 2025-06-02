#!/usr/bin/env zsh

zstyle ':completion:*' completer _extensions _complete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

fpath=("$XDG_DATA_HOME/zsh/completions" /usr/share/zsh/site-functions /usr/share/zsh/vendor-completions $fpath)
# zmodload zsh/complist
_comp_options+=(globdots) # With hidden files
autoload -U compinit; compinit

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
