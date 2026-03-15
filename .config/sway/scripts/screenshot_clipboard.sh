#!/usr/bin/env zsh

if pgrep flameshot; then
  pkill flameshot
fi

flameshot gui --raw -s | xclip -selection clipboard -t image/png && dunstify Image copy to clipboard
