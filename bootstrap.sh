#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";




#git pull origin master;
# added brew.sh and install_geo.sh to the no go since I did it by hand.  remove next time
# added setup_notes.md and sublime.md and dotfiles.Rproj and .Rproj.user (this one I forgot!!)

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "install_geo.sh" \
		--exclude "README.md" \
		--exclude "setup_notes.md" \
		--exclude ".Rproj.user" \
		--exclude "sublime.md" \
		--exclude "dotfiles.Rproj" \
		--exclude ".Rhistory" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	if [ -n "$ZSH_VERSION" ]; then
            source ~/.zshrc;
        elif [ -n "$BASH_VERSION" ]; then
            source ~/.bash_profile;
        else
            echo 'unknown shell'
        fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
