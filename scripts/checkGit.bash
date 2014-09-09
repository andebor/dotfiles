#!/bin/bash
######################
# checkgit.sh
# This script checks remote git repo to see if local repo is up to date and
# download any changes.
#
# Currently not operational!!
######################

dir=~/dotfiles/.git     # local git repo

if ! git --git-dir="$dir" diff --quiet
then
	git --git-dir="$dir" pull origin master
	echo "Lastest bashrc was downloaded!"
else
	echo "bashrc is up to date!"
fi
