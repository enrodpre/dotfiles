# Unset so it is only kitty's matter (navigate thru windows)

bindkey -r "^J"
bindkey -r "^H"
bindkey -r "^K"
bindkey -r "^L"

bindkey '^R' history-incremental-search-backward
bindkey -M viins '^Y' forward-char
