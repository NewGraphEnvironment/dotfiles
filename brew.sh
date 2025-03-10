#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install a modern version of Bash.
brew install bash
brew install bash-completion@2



# Switch to using brew-installed bash as default shell
# I this messes up we can revert like this https://stackoverflow.com/questions/55562522/when-i-start-my-terminal-i-get-login-usr-local-bin-bash-no-such-file-or-dire
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# direnv can be useful
# brew install direnv

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install gs
brew install imagemagick #--with-webp
brew install p7zip
brew install tree

# from https://github.com/cds-snc/laptop/blob/master/Brewfile
brew install node
brew install hub

# nneded to force these since they were already installed
brew install --cask iterm2 --force
brew install --cask the-unarchiver --force
brew install --cask google-chrome --force
brew install --cask firefox --force
brew install --cask slack --force
brew install --cask sublime-text --force
brew install --cask visual-studio-code --force
# brew install --cask dropbox -- use beta with m1 support for now
brew install --cask docker --force


# 202205 al

brew install --cask zotero
# fixes issues with pdftools and rayshader packages
brew install --cask xquartz
# deals with keychain for git gpg signing
brew install --cask gpg-suite

brew install awk
brew install zoom
brew install --cask zoom
brew install zotero  
brew install doctl
brew install s3cmd
brew install libmagic

# for focus
brew install --cask pomatez

# install miniconda with brew and initialize
brew install --cask miniconda

# it tells me to run this line below but it didn't work
# conda init "$(basename "${SHELL}")"
# then it told me to initialize the shell with 
conda init bash
conda config --set auto_activate_base false

# I went to manually do the same thing in the zsh shell but it seemed to work already. hmm.

# Remove outdated versions from the cellar.
brew cleanup
