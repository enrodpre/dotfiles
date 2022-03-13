export ZSH=$HOME/.config/zsh

for configfile in $(find "$ZSH" -executable -name "*.zsh"); do
  source "$configfile"
done
