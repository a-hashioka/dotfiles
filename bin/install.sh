#!/bin/bash
set -euo pipefail

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git gnupg ca-certificates software-properties-common

# add neovim ppa for latest version of neovim
sudo add-apt-repository ppa:neovim-ppa/stable

# add docker repository for latest version of docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt upgrade -y
PACKAGES=(
  zsh     # shell
  htop    # system monitor
  xsel    # clipboard manager
  stow    # symlink manager
  tree    # directory viewer
  neovim  # editor
  ripgrep # search tool
  fd-find # finder
  # docker (containerization platform)
  docker-ce 
  docker-ce-cli 
  containerd.io 
  docker-buildx-plugin 
  docker-compose-plugin
)
sudo apt install -y "${PACKAGES[@]}"

# add current user to docker group to use docker without sudo
#sudo usermod -aG docker $USER

# install ghostty(terminal emulator)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# install fzf(fuzzy finder)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install LazyVim　(starter template for neovim)
git clone https://github.com/LazyVim/starter ~/.config/nvim/
rm -rf ~/.config/nvim/.git

# install lazygit　(git ui)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz
rm -rf lazygit

# install nerd font(JetBrains Mono)
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv

DOTFILES=(
  bash
  zsh
  git
  ghostty
  nvim
)
cd ~/dotfiles && stow -vR "${DOTFILES[@]}"

echo "Installation completed!"
