#!/bin/bash

# Update repositories
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y

# Install default applications
sudo apt-get install git gparted mc mcedit vim virtualbox-dkms virtualbox remmina remmina-plugin-rdp chromium-browser vagrant xbacklight xbindkeys gnome-system-monitor httpie python-pip rar unrar zsh k3b myrepos -y

# Install additional stuff
sudo apt-get install jq -y

# git kurwa
cp .gitconfig ~/

# Sign the commits by default
# https://help.github.com/articles/signing-commits-using-gpg/
# gpg2 --list-keys
# git config --global user.signingkey <KEY_NUMBER>
# gpg2 --armor --export <KEY_NUMBER>
git config --global commit.gpgsign true

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

sudo chown marcin:marcin ~/.zshrc
cp .zshrc ~/

# Installing plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install ansible
sudo apt-get install software-properties-common ansible -y

# Openshift stuff
sudo apt-get install ruby-full ruby git-core -y

# Bind shortcuts to inc/dec brightness
cat > ~/.xbindkeysrc << EOF
"xbacklight -dec 2"
    Control + Shift + minus

"xbacklight -inc 2"
    Control + Shift + plus
EOF

# APPROACH 3
# backlight keys are working again
# http://ubuntuforums.org/showthread.php?t=1605498
# also installed acpi-support:i386 (don't know if relevant)
# sudo apt-get install acpi-support:i386
sudo sed 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="i915.powersave=0 acpi_backlight=vendor vga=792 quiet splash""i915.powersave=0 acpi_backlight=vendor vga=792 quiet splash"/g' /etc/default/grub
sudo cp etc/acpi/*.sh /etc/acpi
sudo update-grub

# Upgrade
sudo apt-get upgrade -y

# Remove obsolete packages
sudo apt-get autoremove -y

## INSTALL ALL THE JDKS ANS STUFF

# Install SDKMAN
curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# INSTALL STUFF VIA SDK
yes | sdk install java
yes | sdk install groovy
yes | sdk install gradle
yes | sdk install springboot
yes | sdk install maven
yes | sdk install asciidoctorj

# Update Inotify watch limit for IntelliJ - https://confluence.jetbrains.com/pages/viewpage.action?pageId=25788581
echo "fs.inotify.max_user_watches = 131072" | sudo tee --append /etc/sysctl.conf
sudo sysctl -p

# remove old stuff
sudo apt-get autoremove -y

# INSTALL DOCKER
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo rm -f /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" | sudo tee --append /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get install linux-image-extra-$(uname -r)
sudo apt-get install docker-engine
sudo service docker start

sudo curl -sSL https://get.docker.com/gpg | sudo apt-key add -
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker marcin

# INSTALL DOCKER-COMPOSE
pip install --upgrade pip
sudo pip install -U docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# TOR BROWSER
# https://www.torproject.org/projects/torbrowser.html.en

# INSTALL ATOM
wget -O /tmp/atom-amd64.deb https://github.com/atom/atom/releases/download/v1.1.0/atom-amd64.deb
sudo dpkg --install /tmp/atom-amd64.deb

# INSTALL ATOM PACKAGES
apm install language-groovy atom-beautify merge-conflicts minimap file-icons travis-ci-status open-recent monokai-seti seti-ui todo-show highlight-selected minimap-highlight-selected autoclose-html pigments linter linter-javac linter-shellcheck linter-jsonlint linter-js-yaml auto-detect-indentation atom-beautify rest-client atom-maven intellij-idea-keymap

# Install Nodejs
curl -sL "https://deb.nodesource.com/setup_4.x" | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# Install pipelight
sudo add-apt-repository ppa:pipelight/stable
sudo apt-get update
sudo apt-get install -y --install-recommends pipelight-multi
sudo pipelight-plugin --update

# Install Slack client
wget -O /tmp/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.3.4-amd64.deb
sudo dpkg -i /tmp/slack.deb
sudo apt-get -f install -y

# Install Intellij idea
wget -O /tmp/idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2016.3.2.tar.gz
mkdir $HOME/apps/JetBrains --parents
tar -xf /tmp/idea.tar.gz -C $HOME/apps/JetBrains/
ln -s $HOME/apps/JetBrains/idea-IU-163.10154.41 $HOME/apps/JetBrains/intellij
# REMEMBER TO IMPORT SETTINGS FROM idea_settings.jar

# Install Skype
sudo apt-get install libqt4-dbus libqt4-network libqt4-xml libasound2 -y
cd /tmp
wget http://www.skype.com/go/getskype-linux-beta-ubuntu-64
sudo dpkg -i getskype-*
sudo apt-get -f install -y

# Install hipchat
# echo "deb http://downloads.hipchat.com/linux/apt stable main" | sudo tee --append /etc/apt/sources.list.d/atlassian-hipchat.list
# sudo wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install hipchat -y

# Install Hangouts plugin
wget -O /tmp/hangouts.deb https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
sudo dpkg -i /tmp/hangouts.deb

# Xubuntu issues  - https://bugs.launchpad.net/ubuntu/+source/light-locker/+bug/1320989
sudo add-apt-repository ppa:xubuntu-dev/ppa
sudo apt-get update && sudo apt-get install xfce4-power-manager light-locker-settings

# REMEMBER TO CHANGE DRIVERS TO NVIDIA!!

# Install Viber
wget -O /tmp/viber.deb http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo dpkg -i /tmp/viber.deb

# Install imapsync
sudo apt-get install makepasswd rcs perl-doc libio-tee-perl git libmail-imapclient-perl libdigest-md5-file-perl libterm-readkey-perl libfile-copy-recursive-perl build-essential make automake libunicode-string-perl -y

# Install RVM
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
echo "rvm default" >> ~/.config/fish/config.fish
gem install bundler
# For Octopress blog:
#rbenv rehash    # If you use rbenv, rehash to be able to run the bundle command
#bundle install

# http://askubuntu.com/questions/626078/mouse-cursor-invisible-after-15-04-update
sudo apt-get install gdm -y

# INSTALL https://www.privateinternetaccess.com/pages/downloads
echo "Private internet access installation"
mkdir --parents ~/PIA
curl https://www.privateinternetaccess.com/openvpn/openvpn.zip -o ~/PIA/openvpn.zip
unzip ~/PIA/openvpn.zip -d ~/PIA
