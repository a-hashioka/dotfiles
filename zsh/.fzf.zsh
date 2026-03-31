# Setup fzf
# ---------
if [[ ! "$PATH" == */home/a-hashioka/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/a-hashioka/.fzf/bin"
fi

source <(fzf --zsh)
