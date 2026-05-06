###aliases###
# colorize ls and grep output
if [[ -x /usr/bin/dircolors ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some eza aliases
alias ls='eza --icons --group-directories-first --color=auto'
alias ll='eza -alh --icons --group-directories-first --color=auto --time-style=long-iso --git --git-repos'

# some cd aliases
alias ...='../../'
alias ..='cd ../'
alias ~='cd ~/'

# some mv and cp aliases
alias mv='mv -i'
alias cp='cp -i'

# fd alias
alias fd='fdfind'
alias fa='fdfind -IH'
alias fdir='fdfind -H --type d'

# some xsel aliases
alias xcp='xsel -bi'
alias xps='xsel -bo'
alias xx='xsel -bo | zsh'

# some tree aliases
alias tree='eza --tree --icons --color=auto'
alias atree='eza -a --tree --icons --color=auto -I .git'
alias xtree='eza -a --tree --color=auto -I .git | xsel -bi'

# stow alias
alias stow='stow -v'

# pnpm alias
alias pnpx='pnpm dlx'