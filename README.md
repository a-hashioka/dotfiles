# dotfiles

## installer

Place the `dotfiles/` directory in your home directory.

```sh
cd ~
git clone 
./dotfiles/bin/install.sh
```

## packages

## remote access protcol

- ssh

### version control

- git

### shell

- bash
- zsh

### terminal emulator

- ghostty

### code editor

- neovim

## directory tree

```txt
.
├── .gitignore
├── README.md
├── bash
│   ├── .bash_logout
│   ├── .bashrc
│   └── .fzf.bash
├── bin
│   ├── install.sh
│   └── setup.sh
├── ghostty
│   └── .config
│       └── ghostty
│           └── config.ghostty
├── git
│   └── .gitconfig
├── nvim
│   └── .config
│       └── nvim
│           ├── .gitignore
│           ├── .neoconf.json
│           ├── LICENSE
│           ├── README.md
│           ├── init.lua
│           ├── lazy-lock.json
│           ├── lazyvim.json
│           ├── lua
│           │   ├── config
│           │   │   ├── autocmds.lua
│           │   │   ├── keymaps.lua
│           │   │   ├── lazy.lua
│           │   │   └── options.lua
│           │   └── plugins
│           │       └── example.lua
│           └── stylua.toml
├── ssh
│   └── .ssh
│       └── config
└── zsh
    ├── .fzf.zsh
    ├── .p10k.zsh
    └── .zshrc

16 directories, 26 files
```
