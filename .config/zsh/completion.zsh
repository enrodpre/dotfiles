#!/usr/bin/env zsh

zstyle ':completion:*' completer _extensions _complete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

_comp_options+=(globdots) # With hidden files
autoload -Uz compinit && compinit
autoload -U bashcompinit && bashcompinit

eval "$(register-python-argcomplete pipx)"
source $(pew shell_config)
