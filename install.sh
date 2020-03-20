#!/bin/bash

check_command_exists() {
	if ! [ -x "$(command -v $1)" ]; then
		echo $1 is not available on the system, exiting...
		exit 1
	fi
}

install_app() {
	if [[ -f "$1/df-pre-stow.sh" ]]; then
		source ./$1/df-pre-stow.sh
	fi
	stow $1
	if [[ -f "$1/df-install.sh" ]]; then
		source ./$1/df-install.sh
	fi
}

# we create this directory first so that stow
# will not make a symlink directly for this
# directory and only create symlinks for its
# subdirectories
mkdir -p $HOME/.config

check_command_exists stow
stow stow-ignore
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
