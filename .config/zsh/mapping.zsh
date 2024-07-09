function run-again {
    zle up-history
    zle accept-line
}

function feed-suggestion {
    zle autosuggest-accept
    zle accept-line
}

zle -N run-again
zle -N feed-suggestion

# Unset so it is only kitty's matter (navigate thru windows)
bindkey -r "^J"
bindkey -r "^H"
bindkey -r "^K"
bindkey -r "^L"

bindkey '^R' history-incremental-search-backward

bindkey '^[[121;9u' autosuggest-accept

bindkey '^[[120;9u' run-again

# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -M vicmd cs change-surround
# bindkey -M vicmd ds delete-surround
# bindkey -M vicmd ys add-surround
# bindkey -M visual S add-surround
