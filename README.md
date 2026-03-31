# dotfiles

## installer

Place the `dotfiles/` directory in your home directory.

```sh
cd dotfiles/bin/
chmod u+x install.sh
./install.sh
```

## packages

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
│           ├── lua
│           │   ├── config
│           │   │   ├── autocmds.lua
│           │   │   ├── keymaps.lua
│           │   │   ├── lazy.lua
│           │   │   └── options.lua
│           │   └── plugins
│           │       └── example.lua
│           └── stylua.toml
└── zsh
    ├── .fzf.zsh
    ├── .p10k.zsh
    └── .zshrc

14 directories, 23 files
```
