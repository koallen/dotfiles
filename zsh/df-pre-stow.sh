#!/bin/bash

if [ ! -L "$HOME/.zshrc" ]; then
    echo Existing .zshrc found, backing up to .zshrc.dotfiles-install.bak
    mv $HOME/.zshrc $HOME/.zshrc.dotfiles-install.bak
fi
