#!/usr/bin/zsh

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

# Reloads zsh config
reloadzsh() {
    if [ -n "$(jobs)" ]; then
        print -P "Error: %j job(s) in background"
    else
        notify "Reloaded zsh"
        clear_this_line
        printf '\033[1A';
        exec zsh
    fi
}

# Clears the entire current line regerdless of terminal size.
clear_this_line(){
    printf '\r'
    cols="$(tput cols)"
    for i in $(seq "$cols"); do
        printf ' '
    done
    printf '\r'
}

# Erases the amount of lines specified.
# $1 lines to erase
erase_lines(){
    # Default line count to 1.
    test -z "$1" && lines="1" || lines="$1"

    # This is what we use to move the cursor to previous lines.
    UP='\033[1A'

    # Erase.
    if [ "$lines" = 1 ]; then
        clear_this_line
    else
        lines=$((lines-1))
        clear_this_line
        for i in $(seq "$lines"); do
            printf "$UP"
            clear_this_line
        done
    fi
}

# Print binaries from package
# $1 package to list
pkgbin() {
    paru -Ql "$1" | grep -e '/bin/.' | cut -f 2- -d ' '
}

# Search for a env var
var() {
    printenv | grep "$1"
}

# Get childrens' pid of parent
# $1 -> parent
# $2 -> child pattern
pschildren() {
    pgrep "$1"| while read parent; do pgrep "$2" -P "$parent"; done
}

# Find text in not ignored files in git (might be more accurate)
# $1 pattern
dots_find() {
    filter_exists() {
        test -e $1 && echo $1
    }
    dots ls-files $HOME --full-name --exclude-standard | while read file; do filter_exists $HOME/$file; done | tr '\n' ' '| xargs rg "$1" 2>/dev/null
}

# Debug command or function
# $@ command or function
debug() {
    set -x
    $@
    set +x
}

# Try to output i3 mappings
i3maps() {
    grep -Eo "^[^#].*mod\+[0-9A-Za-z\+]+.*" $HOME/.config/i3/mapping | sed -e "s/mod+//" | grep "\$$1"
}

# echoes() {
#         echo "${1%% *}"
# }

# Extract function names
# $1 file to extract
funcnames () {
    sed -nE 's/^function[[:space:]]+([a-zA-Z_][a-zA-Z0-9_\-]+)[[:space:]]?\(\)[[:space:]]*\{/\1/p' $1
}

# create dir and cd to it
mkcd() {
    mkdir -p $1
    cd $1
}
