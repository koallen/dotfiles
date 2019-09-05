#!/bin/bash

echo Checking if stow command is available
if ! [ -x "$(command -v stow)" ];
then
	echo Stow is not available on the system, exiting...
	exit 1
fi

echo Going to install application dotfiles with stow
for app in * ;
do
	if [[ -d $app ]];
	then
		read -p "Do you want to install $app? (N/y) " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			# we move the install script to a temp file,
			# install it, and then move it back here
			TMPFILE=$(mktemp)
			mv $app/install.sh $TMPFILE
			stow $app
			$TMPFILE
			mv $TMPFILE $app/install.sh
		fi
	fi
done
