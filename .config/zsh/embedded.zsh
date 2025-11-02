#!/usr/bin/env zsh

setopt PROMPT_SUBST

export PROMPT="%F{76}>%f "
# export PROMPT_COMMAND='printf "\033]51;ExitCode=%d\007" $?'

export RPROMPT='%(?.%F{green}✓%f.%F{red}✘ %?%f)'
