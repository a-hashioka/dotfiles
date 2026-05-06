# install and initialize zplug
export ZPLUG_HOME="$HOME/.zplug"
if [[ ! -d "$ZPLUG_HOME" ]]; then
    curl -L --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    echo "Installation completed! Restart your terminal."
else
    source $ZPLUG_HOME/init.zsh

    # install plugins
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-completions", defer:2 
    zplug "romkatv/powerlevel10k", as:theme, depth:1
    if ! zplug check --verbose; then
        printf "Installing plugins...\n"
        zplug install
    fi

    # load plugins
    zplug load 
fi