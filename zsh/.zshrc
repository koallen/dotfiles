# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Zsh theme
ZSH_THEME="candy"

# Date format in history command
HIST_STAMPS="dd.mm.yyyy"

# Zsh plugins
plugins=(autojump)

source $ZSH/oh-my-zsh.sh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export EDITOR="vim"

# load machine specific configurations from ZSHRC_LOCAL
ZSHRC_LOCAL="$HOME/.zshrc.local"
if [ -f "${ZSHRC_LOCAL}" ]; then
	source ${ZSHRC_LOCAL}
fi
