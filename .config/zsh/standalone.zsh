#!/usr/bin/env zsh


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f $ZDOTDIR/p10k.zsh ]] || source "$ZDOTDIR/p10k.zsh"

source $ZDOTDIR/vi-mode.zsh

