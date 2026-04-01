#!/bin/bash

###install packages###
# add neovim ppa for latest version of neovim
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt update && sudo apt upgrade -y

PACKAGES=(
  curl
  wget
  git
  zsh     # shell
  htop    # system monitor
  xsel    # clipboard manager
  stow    # symlink manager
  tree    # directory viewer
  neovim  # editor
  ripgrep # search tool
  fd-find # finder
  # nautilus-dropbox #cloud
)
sudo apt install -y "${PACKAGES[@]}"

# fd -> fd-find
sudo ln -s $(which fdfind) /usr/bin/fd

# install ghostty(terminal emulator)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# install fzf(fuzzy finder)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install LazyVim　(starter template for neovim)
git clone https://github.com/LazyVim/starter ~/.config/nvim/
rm -rf ~/.config/nvim/.git

# install lazygit　(git ui)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*")')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz
rm -rf lazygit

# install vscode
wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ./code.deb
rm vscode.deb

###make symlink###
DOTFILES=(
  bash
  zsh
  git
  ghostty
  nvim
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
