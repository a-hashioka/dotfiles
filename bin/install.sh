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

# install ghostty(terminal emulator)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# install fzf(fuzzy finder)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ./code.deb
rm vscode.deb

###make symlink###
DOTFILES=(
    bash
    zsh
    git
    ghostty
) 
cd ~/dotfiles && stow -vR "${DOTFILES[@]}"

###install nerd font(JetBrains Mono)###
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf \
https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv

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