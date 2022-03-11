# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Zsh theme
ZSH_THEME="candy"

# Date format in history command
HIST_STAMPS="dd.mm.yyyy"

# Zsh plugins
#
# - fzf provides integration with Ctrl-R
# - fzf-tab allows using fzf for auto completion
plugins=(autojump colored-man-pages web-search fzf fzf-tab)

source $ZSH/oh-my-zsh.sh

# Color theme
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Zsh options
unsetopt AUTO_CD

# modify PATH
prepend_path() {
    local abs_path=$1
    if [ -d "$abs_path" ]; then
        case "$PATH" in
            *"$abs_path"*)
                :
                ;;
            *)
                path=($abs_path $path)
                ;;
        esac
    fi
}

mkdir -p $HOME/.local/bin
prepend_path $HOME/.local/bin

# common aliases
alias rm="rm -i"
if [ -x "$(command -v nvim)" ]; then
	alias vim="nvim"
fi
if [ -x "$(command -v tmux)" ]; then
	alias ts="tmux new-session -A -s awesome-tmux"
fi

# env variables
if [ -x "$(command -v vim)" ] || [ -x "$(command -v nvim)" ] ; then
	export EDITOR="vim"
else
	export EDITOR="vi"
fi

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"

# load machine specific configurations from ZSHRC_LOCAL
ZSHRC_LOCAL="$HOME/.zshrc.local"
if [ -f "${ZSHRC_LOCAL}" ]; then
	source ${ZSHRC_LOCAL}
fi
