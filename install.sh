#!/bin/bash

check_command_exists() {
	if ! [ -x "$(command -v $1)" ]; then
		echo $1 is not available on the system, exiting...
		exit 1
	fi
}

install_app() {
	stow $1
	if [[ -x "$1/install.sh" ]]; then
		./$1/install.sh
	fi
}

# this function is exported so that dotfile internal
# install scripts can use this function
export -f check_command_exists

# we create this directory first so that stow
# will not make a symlink directly for this
# directory and only create symlinks for its
# subdirectories
mkdir -p $HOME/.config

check_command_exists stow
if [[ "$#" -eq "0" ]]; then
	echo Going to install application dotfiles with stow
	for app in * ; do
		if [[ -d $app ]]; then
			read -p "Do you want to install $app? (N/y) " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				install_app $app
			fi
		fi
	done
else
	for app in "$@"; do
		echo Installing dotfile for $app
		install_app $app
	done
fi
