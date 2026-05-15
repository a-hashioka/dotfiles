#!/bin/bash
set -euo pipefail

# ==============================================================================
# SYSTEM PACKAGES INSTALLATION (APT)
# ==============================================================================

echo "[*] Updating and upgrading system packages..."
sudo apt-get update && sudo apt-get upgrade -y

PACKAGES=(
  # CLI Tools
  curl    # Data transfer tool
  wget    # Network downloader
  git     # Version control system
  gnupg   # GNU privacy guard
  stow    # Symlink manager
  ripgrep # Search tool
  fd-find # File finder
  eza     # Modern ls replacement
  bat     # Modern cat replacement
  htop    # System monitor
  xsel    # Clipboard manager

  # Development Tools
  build-essential # Essential packages for building software
  tar             # Archiving utility
  pkg-config      # Package configuration tool

  # Languages & Interpreters
  zsh    # Shell
  pipx   # Python package installer
  octave # Numerical computing environment

  # Development Libraries
  libsqlite3-dev     # SQLite3 development files
  libfontconfig1-dev # Fontconfig development files
  libgraphite2-dev   # Graphite2 development files
  libharfbuzz-dev    # Harfbuzz development files
  libicu-dev         # ICU development files
  libssl-dev         # OpenSSL development files
  zlib1g-dev         # Zlib development files
  libpng-dev         # PNG development files
  libopencv-dev      # OpenCV development files

  # Multimedia & Graphics
  imagemagick # Image manipulation tool
  sqlite3     # Database engine

  # Graphics & Display Libraries
  libatk1.0-0t64        # ATK accessibility toolkit
  libatk-bridge2.0-0t64 # ATK bridge for accessibility
  libcups2t64           # CUPS printing system
  libdrm2               # DRM library
  libxkbcommon0         # XKB common library
  libxcomposite1        # X11 composite extension
  libxdamage1           # X11 damage extension
  libxrandr2            # X11 RandR extension
  libgbm1               # GBM library
  libpango-1.0-0        # Pango text rendering library
  libcairo2             # Cairo graphics library
  libasound2t64         # ALSA sound library
)

echo "[*] Installing core packages..."
sudo apt-get install -y "${PACKAGES[@]}"

# Install packages from PPAs
echo "[*] Installing packages from PPAs..."
PPAS=(
  ppa:neovim-ppa/stable
  ppa:mkasberg/ghostty-ubuntu
  ppa:zhangsongcui3371/fastfetch
)
for ppa in "${PPAS[@]}"; do
  sudo add-apt-repository -y "$ppa" >/dev/null
done
sudo apt-get update
sudo apt-get install -y neovim ghostty fastfetch

# ==============================================================================
# RUST ECOSYSTEM
# ==============================================================================

echo "[*] Installing Rust and Cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

echo "[*] Installing tectonic (modern LaTeX engine)..."
export TECTONIC_DEP_BACKEND=external
cargo install tectonic

# ==============================================================================
# NODE.JS ECOSYSTEM
# ==============================================================================

echo "[*] Installing fnm (Node.js version manager)..."
curl -fsSL https://fnm.vercel.app/install | bash

echo "[*] Installing latest LTS version of Node.js..."
fnm install --lts
npm install -g npm@latest
corepack enable

echo "[*] Installing global npm packages..."
npm install -g tree-sitter-cli         # Parser generator for Neovim Treesitter
npm install -g neovim                  # Neovim client for Node.js plugin development
npm install -g @mermaid-js/mermaid-cli # Mermaid CLI for diagram generation
npm install -g typescript              # TypeScript language server for Neovim LSP

# ==============================================================================
# PYTHON ECOSYSTEM
# ==============================================================================

echo "[*] Installing Python tools..."
pipx ensurepath
pipx install pynvim # Neovim Python support
pipx install uv     # Fast Python dev environment manager

# ==============================================================================
# GIT REPOSITORIES
# ==============================================================================

echo "[*] Installing LazyVim (Neovim starter configuration)..."
mkdir -p "$HOME/.config"
git clone -q https://github.com/LazyVim/starter "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/.git"

echo "[*] Installing fzf (Fuzzy finder)..."
git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all >/dev/null

# ==============================================================================
# WEB DOWNLOADS & EXTERNAL SERVICES
# ==============================================================================

echo "[*] Installing lazygit (Git UI)..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -fLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin
rm -f lazygit.tar.gz lazygit

echo "[*] Installing Docker (Container platform)..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ==============================================================================
# FONTS & FINAL SETUP
# ==============================================================================

echo "[*] Installing JetBrains Mono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
curl -fLo "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv

echo "[+] Installation completed!"
