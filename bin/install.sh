#!/bin/bash

###install packages###
sudo apt update && sudo apt upgrade -y

PACKAGES=(
    curl
    wget
    git
    zsh # shell
    htop # system monitor 
    xsel # clipboard manager
    stow  # symlink manager
    tree # directory viewer
    # nautilus-dropbox #cloud
)
sudo apt install -y "${PACKAGES[@]}"

wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ./code.deb
rm vscode.deb

###make symlink###
DOTFILES=(
    bash
    zsh
    git
) 
cd ~/dotfiles && stow -vR "${DOTFILES[@]}"

###make desktop shortcuts###
# DESKTOP=(
#     "code"
#     "dropbox"
# )
# mkdir -p ~/Desktop
# for app in "${DESKTOP[@]}";do
#     cp "/usr/share/applications/${app}.desktop" ~/Desktop/
# done

echo "Installation completed!"