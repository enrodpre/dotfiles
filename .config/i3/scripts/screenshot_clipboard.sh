#!/usr/bin/env zsh

flameshot gui --raw -s | xclip -selection clipboard -t image/png && dunstify Image copy to clipboard
