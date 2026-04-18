#!/bin/bash
 
LANG=C xdg-user-dirs-update --force # update user directories to default
chsh -s "$(which zsh)" # change default shell to zsh
sudo usermod -aG docker "$USER" # add current user to docker group to use docker without sudo