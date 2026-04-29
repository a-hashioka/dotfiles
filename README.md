# dotfiles

## installer

Place the `dotfiles/` directory in your home directory.

```sh
cd ~
git clone 
./dotfiles/bin/install.sh
```

## packages

### remote access protcol

- ssh

### version control

- git

### shell

- zsh

### terminal emulator

- ghostty

### code editor

- neovim

## directory tree

```txt
.
├── .gitignore
├── bin
│  ├── init_env.sh
│  ├── install.sh
│  └── stow.sh
├── ghostty
│  └── .config
│     └── ghostty
│        └── config.ghostty
├── git
│  └── .gitconfig
├── nvim
│  └── .config
│     └── nvim
│        ├── .neoconf.json
│        ├── init.lua
│        ├── lazy-lock.json
│        ├── lua
│        │  ├── config
│        │  │  ├── autocmds.lua
│        │  │  ├── keymaps.lua
│        │  │  ├── lazy.lua
│        │  │  └── options.lua
│        │  └── plugins
│        │     ├── colortheme.lua
│        │     ├── dashboard.lua
│        │     └── example.lua
│        └── stylua.toml
├── README.md
├── ssh
│  └── .ssh
│     └── config
└── zsh
   ├── .fzf.zsh
   ├── .p10k.zsh
   └── .zshrc
```
