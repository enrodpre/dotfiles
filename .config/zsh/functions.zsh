#!/usr/bin/zsh

function d() {
  local dir
  dir=$(dirs -v | fzf --height 40% --reverse --prompt="cd to: " | awk '{print $2}')
  [[ -n "$dir" ]] && cd "${dir/#\~/$HOME}"
}

# Send to text to polybar
# $1 text to send
# $2 time to wait until send reset
notifybar() {
  if [[ -n "$1" ]]; then
    polybar-msg action message send "$1" >/dev/null
    {
      sleep "${2-3}"
      polybar-msg action message reset >/dev/null
    } &
  fi >/dev/null
  # test -n "$1" && { >/dev/null && sleep ${2-3} 2>&1 >/dev/null && polybar-msg action message reset } >/dev/null 2>&1 2>&1 >/dev/null &
} #>/dev/null 2>&1

# Setups environment for hacking
# $1 machine name
# $2 machine ip
start_attack() {
  machine="$1"
  ip="$2"

  cd ~/htb
  mkdir "$machine"
  cd "$machine"
  mkdir content exploits scans
}

# Find text in not ignored files in git (might be more accurate)
# $1 pattern
dots_find() {
  filter_exists() {
    test -e "$1" && echo "$1"
  }
  dots ls-files "$HOME" --full-name --exclude-standard | while read file; do filter_exists "$HOME/$file"; done | tr '\n' ' ' | xargs rg "$1" 2>/dev/null
}

# Debug command or function
# $@ command or function
debug() {
  set -x
  "$@"
  set +x
}

# Try to output i3 mappings
swaymaps() {
  grep -Eo "^[^#].*mod\+[0-9A-Za-z\+]+.*" "$HOME"/.config/sway/mapping | sed -e "s/mod+//" | grep "\$$1"
}

# Extract function names
# $1 file to extract
funcnames() {
  sed -nE 's/^function[[:space:]]+([a-zA-Z_][a-zA-Z0-9_\-]+)[[:space:]]?\(\)[[:space:]]*\{/\1/p' "$1"
}

# create dir and cd to it
mkcd() {
  mkdir -p "$1"
  cd "$1"
}

trim() {
  cat | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}
