autoload -Uz compinit && compinit

export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Key bindings

bindkey -r "^J"
bindkey -r "^H"
bindkey -r "^K"
bindkey -r "^L"

bindkey '^R' history-incremental-search-backward

source $ZDOTDIR/plugins/git-prompt.sh

setopt PROMPT_SUBST
# Prompt
PROMPT='%F{green}%3c%f%F{blue} [ '
RPROMPT='%F{white}$(__git_ps1 " %s")%f%F{blue} ] %F{green}%T'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
