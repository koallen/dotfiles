# Path to your oh-my-zsh installation.
export ZSH=/home/koallen/.oh-my-zsh

# Zsh theme
ZSH_THEME="candy"

# Date format in history command
HIST_STAMPS="dd.mm.yyyy"

# Zsh plugins
plugins=(autojump)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/android-studio/bin:$PATH
export PATH=/usr/local/cuda/bin:$PATH

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export EDITOR="vim"
