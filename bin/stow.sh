#!/bin/bash

DOTFILES=(
  zsh
  git
  ghostty
  nvim
  ssh
)
echo "[*] Setting up dotfiles with stow..."
cd "$HOME/dotfiles" && stow -v --adopt "${DOTFILES[@]}" && git checkout -q -- .