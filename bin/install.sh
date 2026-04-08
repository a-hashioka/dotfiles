#!/bin/bash
set -euo pipefail

echo "[*] Updating and upgrading system packages..."
sudo apt-get update && sudo apt-get upgrade -y
PACKAGES=(
  curl    # data transfer tool
  wget    # network downloader
  git     # version control system
  gnupg   # GNU privacy guard
  build-essential # essential packages for building software
  gfortran # Fortran compiler
  tar     # archiving utility
  zsh     # shell
  htop    # system monitor
  xsel    # clipboard manager
  stow    # symlink manager
  tree    # directory viewer
  ripgrep # search tool
  fd-find # finder
)
echo "[*] Installing core packages..."
sudo apt-get install -y "${PACKAGES[@]}"

# install fzf(fuzzy finder)
echo "[*] Installing fzf..."
git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all > /dev/null

DOTFILES=(
  bash
  zsh
  git
  ghostty
  nvim
)
echo "[*] Setting up dotfiles with stow..."
cd "$HOME/dotfiles" && stow -v --adopt "${DOTFILES[@]}" && git checkout -q -- .

echo "[+] Installation completed!"
