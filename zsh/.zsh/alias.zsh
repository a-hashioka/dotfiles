###aliases###
# colorize ls and grep output
if [[ -x /usr/bin/dircolors ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# eza alias
alias ls='eza --icons --group-directories-first --color=auto'
alias ll='eza -alh --icons --group-directories-first --color=auto --time-style=long-iso --git --git-repos'

# bat alias
alias cat='batcat --paging=never'

# cd alias
alias ...='../../'
alias ..='cd ../'
alias ~='cd ~/'

# mv and cp alias
alias mv='mv -i'
alias cp='cp -i'

# fd alias
alias fd='fdfind'
alias fa='fdfind -IH'
alias fdir='fdfind -H --type d'

# xsel alias
alias xcp='xsel -bi'
alias xps='xsel -bo'
alias xx='xsel -bo | zsh'

# tree alias
alias tree='eza --tree --icons --color=auto --git-ignore'
alias atree='eza -a --tree --icons --color=auto --git-ignore'
alias xtree='eza -a --tree --color=auto --git-ignore | xsel -bi'

# stow alias
alias stow='stow -v'

# npm alias
alias cna='npx create-next-app@latest'
