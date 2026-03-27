#!/bin/bash

sudo apt update && sudo apt upgrade -y

PACKAGES=(
    curl
    wget
    git
    zsh # shell
    htop # system monitor 
    xsel # clipboard manager
    stow  # symlink manager
)
sudo apt install -y "${PACKAGES[@]}"

DOTFILES=(
    bash
    zsh
) 
cd ~/dotfiles && stow -R "${DOTFILES[@]}"

echo "installation completed!"