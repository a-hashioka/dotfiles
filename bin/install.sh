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

# install neovim from PPA for latest version
echo "[*] Installing neovim from PPA..."
sudo add-apt-repository -y ppa:neovim-ppa/stable > /dev/null
sudo apt-get update && sudo apt-get install -y neovim

# install docker from official repository for latest version
echo "[*] Installing docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# add current user to docker group to use docker without sudo
# sudo usermod -aG docker "$USER"

# install ghostty(terminal emulator)
echo "[*] Installing ghostty..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# install fzf(fuzzy finder)
echo "[*] Installing fzf..."
git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all > /dev/null

# install LazyVim　(starter template for neovim)
echo "[*] Installing LazyVim..."
mkdir -p "$HOME/.config"
git clone -q https://github.com/LazyVim/starter "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/.git"

# install lazygit　(git ui)echo "[*] Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -fLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin
rm -f lazygit.tar.gz lazygit

# install nerd font(JetBrains Mono)
echo "[*] Installing JetBrains Mono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
curl -fLo "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -q

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
