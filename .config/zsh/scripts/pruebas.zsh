#!/bin/zsh

manager() {
    while IFS= read -r line; do
        echo "manager[$1:$BASHPID]: $line"
    done
}

fds=()
for (( i=0; i<5; i++ )); do
    exec {fd}> >(manager $i)
    fds+=( $fd )
done

while IFS= read -r line; do
    echo "master: $line"
    for fd in "${fds[@]}"; do
        printf -- '%s\n' "$line" >&$fd
    done
done
