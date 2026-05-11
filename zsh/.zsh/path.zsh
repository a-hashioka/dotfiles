# fnm
FNM_PATH="/home/a-hashioka/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# Created by `pipx` on 2026-04-04 06:48:04
export PATH="$PATH:/home/a-hashioka/.local/bin"
