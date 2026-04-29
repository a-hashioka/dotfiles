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
│        ├── .gitignore
│        ├── .neoconf.json
│        ├── init.lua
│        ├── lazy-lock.json
│        ├── lazyvim.json
│        ├── LICENSE
│        ├── lua
│        │  ├── config
│        │  │  ├── autocmds.lua
│        │  │  ├── keymaps.lua
│        │  │  ├── lazy.lua
│        │  │  └── options.lua
│        │  └── plugins
│        │     └── example.lua
│        ├── README.md
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
