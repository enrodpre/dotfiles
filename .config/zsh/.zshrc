source /home/kike/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/kike/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


# Key bindings

bindkey -r "^J"
bindkey -r "^H"
bindkey -r "^K"
bindkey -r "^L"

bindkey '^R' history-incremental-search-backward


# Prompt
PROMPT='%F{green}%4c%F{blue} [%f '
RPROMPT='%F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
