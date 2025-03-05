#!/usr/bin/env zsh

maim -s | xclip -selection clipboard -t image/png && notifybar 'Saved image to clipboard'
