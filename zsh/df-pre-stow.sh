#!/bin/bash

if [ ! -L "$HOME/.zshrc" ]; then
    echo Existing .zshrc found, backing up to .zshrc.dotfiles-install.bak
    mv $HOME/.zshrc $HOME/.zshrc.dotfiles-install.bak
fi

echo Downloading fzf-tab plugin
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
