# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mike/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mike/.fzf/bin"
fi

eval "$(fzf --zsh)"
