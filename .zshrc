# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Zsh theme
ZSH_THEME="candy"

# Date format in history command
HIST_STAMPS="dd.mm.yyyy"

# Zsh plugins
#
# - fzf provides integration with Ctrl-R, and ** completion
# - fzf-tab allows using fzf for tab completion
plugins=(autojump ohmyzsh-full-autoupdate colored-man-pages web-search fzf fzf-tab)

source $ZSH/oh-my-zsh.sh

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

if [ -d /opt/homebrew/bin ]; then
	prepend_path /opt/homebrew/bin
fi

if [ -d "$HOME/.cargo/bin" ]; then
    prepend_path "$HOME/.cargo/bin"
fi

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

if [ -d "$HOME/.zshrc.d" ]; then
    for ZSHRC_D_CONF in $HOME/.zshrc.d/*.zshrc; do
        source ${ZSHRC_D_CONF}
    done
fi

ZSHRC_LOCAL="$HOME/.zshrc.local"
if [ -f "${ZSHRC_LOCAL}" ]; then
	source ${ZSHRC_LOCAL}
fi

# Color theme
tinty init
