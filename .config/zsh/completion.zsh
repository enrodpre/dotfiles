#!/usr/bin/env zsh

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''

_comp_options+=(globdots) # With hidden files
autoload -Uz compinit && compinit
autoload -U bashcompinit && bashcompinit

eval "$(register-python-argcomplete pipx)"
source $(pew shell_config)
