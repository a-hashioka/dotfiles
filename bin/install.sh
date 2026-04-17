#!/bin/bash
set -euo pipefail

echo "[*] Updating and upgrading system packages..."
sudo apt-get update && sudo apt-get upgrade -y
PACKAGES=(
  curl               # data transfer tool
  wget               # network downloader
  git                # version control system
  gnupg              # GNU privacy guard
  build-essential    # essential packages for building software
  tar                # archiving utility
  zsh                # shell
  htop               # system monitor
  xsel               # clipboard manager
  stow               # symlink manager
  tree               # directory viewer
  ripgrep            # search tool
  fd-find            # finder
  pipx               # python package installer
  imagemagick        # image manipulation tool
  octave             # numerical computing environment
  sqlite3            # database engine
  libsqlite3-dev     # sqlite3 development files
  libfontconfig1-dev # fontconfig development files
  libgraphite2-dev   # graphite2 development files
  libharfbuzz-dev    # harfbuzz development files
  libicu-dev         # icu development files
  libssl-dev         # openssl development files
  zlib1g-dev         # zlib development files
  libpng-dev         # png development files
  pkg-config         # package configuration tool
  libopencv-dev      # OpenCV development files for computer vision tasks
)
echo "[*] Installing core packages..."
sudo apt-get install -y "${PACKAGES[@]}"

# install cargo (rust package manager) and rustup (rust toolchain installer)
echo "[*] Installing Rust and Cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# install fnm (fast and simple Node.js version manager)
echo "[*] Installing fnm..."
curl -fsSL https://fnm.vercel.app/install | bash
# install latest LTS version of Node.js using fnm
echo "[*] Installing latest LTS version of Node.js using fnm..."
fnm install --lts
# activate pnpm (fast and efficient package manager) using corepack
corepack enable
corepack prepare pnpm@latest --activate
pnpm setup

# install pnpm global packages
pnpm add -g tree-sitter-cli         # tree-sitter CLI for generating parser for neovim treesitter
pnpm add -g neovim                  # neovim client for nodejs for neovim plugin development
pnpm add -g @mermaid-js/mermaid-cli # mermaid CLI for generating diagrams from mermaid syntax
pnpm approve-builds -g

# install neovim from PPA for latest version
echo "[*] Installing neovim from PPA..."
sudo add-apt-repository -y ppa:neovim-ppa/stable >/dev/null
sudo apt-get update && sudo apt-get install -y neovim

# install pynvim for neovim python support
pipx ensurepath
pipx install pynvim

# install tectonic (modern LaTeX engine)
echo "[*] Installing tectonic..."
export TECTONIC_DEP_BACKEND=external
cargo install tectonic

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

# install docker from official repository for latest version
echo "[*] Installing docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# add current user to docker group to use docker without sudo
sudo usermod -aG docker "$USER"

# install ghostty(terminal emulator)
echo "[*] Installing ghostty..."
sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu
sudo apt update
sudo apt install ghostty

# install fzf(fuzzy finder)
echo "[*] Installing fzf..."
git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all >/dev/null

# install nerd font(JetBrains Mono)
echo "[*] Installing JetBrains Mono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
curl -fLo "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv

DOTFILES=(
  bash
  zsh
  git
  ghostty
  nvim
  ssh
)
echo "[*] Setting up dotfiles with stow..."
cd "$HOME/dotfiles" && stow -v --adopt "${DOTFILES[@]}" && git checkout -q -- .

echo "[+] Installation completed!"
