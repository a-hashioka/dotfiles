#!/bin/bash

LANG=C xdg-user-dirs-update --force
chsh -s "$(which zsh)"