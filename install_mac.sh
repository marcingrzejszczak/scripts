#!/bin/bash

# prerequisites
# GIT

# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# fixing ownership issues
# http://stackoverflow.com/questions/26647412/homebrew-could-not-symlink-usr-local-bin-is-not-writable
sudo chown -R `whoami`:admin /usr/local/bin
sudo chown -R `whoami`:admin /usr/local/opt

# Install default applications
brew install wget midnight-commander Caskroom/cask/mcedit vim Caskroom/cask/vagrant ansible maven mr bash

# git kurwa
cp .gitconfig ~/

# install zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## INSTALL ALL THE JDKS ANS STUFF

# Install SDKMAN
curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Clone ansible-repo
mkdir ~/repo

# INSTALL JDK
# will be installed to: /opt/homebrew-cask/Caskroom/java/
brew tap caskroom/cask
brew install brew-cask
brew cask install java

# INSTALL GROOVY
yes | sdk install groovy

# INSTALL GRADLE
yes | sdk install gradle

# INSTALL SPRINGBOOT
yes | sdk install springboot

# Install ATOM
wget -O /tmp/atom-mac.zip https://github.com/atom/atom/releases/download/v1.2.4/atom-mac.zip
unzip /tmp/atom-mac.zip -d /Applications

# INSTALL ATOM PACKAGES
apm install language-groovy atom-beautify merge-conflicts minimap file-icons travis-ci-status open-recent monokai-seti seti-ui todo-show highlight-selected minimap-highlight-selected autoclose-html pigments linter linter-javac linter-shellcheck linter-jsonlint linter-js-yaml auto-detect-indentation atom-beautify rest-client atom-maven intellij-idea-keymap

# DOCKER
# http://mageinferno.com/blog/using-docker-machine-os-x-dinghy
