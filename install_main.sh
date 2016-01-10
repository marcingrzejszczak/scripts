#!/bin/bash

# Update repositories
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y

# Install default applications
sudo apt-get install git gparted mc mcedit vim virtualbox-dkms virtualbox remmina remmina-plugin-rdp chromium-browser fish vagrant xbacklight xbindkeys gnome-system-monitor httpie python-pip rar unrar maven -y

# git kurwa
cp .gitconfig ~/
# Add Fish as default shell (provide the password)
chsh -s /usr/bin/fish

# Copy all fish related stuff to fish directory
cp fish ~/.config -r

# Install ansible
sudo apt-get install software-properties-common ansible -y

# Openshift stuff
sudo apt-get install ruby-full ruby git-core -y

# Bind shortcuts to inc/dec brightness
cat > ~/.xbindkeysrc << EOF
"xbacklight -dec 10"
    Control + Shift + minus

"xbacklight -inc 10"
    Control + Shift + plus
EOF

# Upgrade
sudo apt-get upgrade -y

# Remove obsolete packages
sudo apt-get autoremove -y

# Remove this stupid Error: diskfilter writes are not supported. from grub
# go to
# sudo vim /etc/grub.d/10_linux
# comment the whole section with recordfail
#   cat << EOF
#      recordfail
#
# run
# sudo update-grub

# Install Jenv
git clone https://github.com/gcuisinier/jenv.git ~/.jenv

## INSTALL ALL THE JDKS ANS STUFF

# Install SDKMAN
curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Clone ansible-repo
git clone git@github.com:microservice-hackathon/ansible-microservice-hackathon.git ~/repo/ansible-microservice-hackathon

# INSTALL JDK and Zookeeper
cp java-playbook.yaml ~/repo/ansible-microservice-hackathon
cd ~/repo/ansible-microservice-hackathon
sudo ansible-playbook -i localhost, -vvvv java-playbook.yaml

# INSTALL GROOVY
yes | sdk install groovy

# INSTALL GRADLE
yes | sdk install gradle

# INSTALL SPRINGBOOT
yes | sdk install springboot

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
sudo pip install -U docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# TOR BROWSER
# https://www.torproject.org/projects/torbrowser.html.en

# INSTALL ATOM
wget -O /tmp/atom-amd64.deb https://github.com/atom/atom/releases/download/v1.1.0/atom-amd64.deb
sudo dpkg --install /tmp/atom-amd64.deb

# INSTALL ATOM PACKAGES
apm install language-groovy an-color-picker atom-beautify merge-conflicts minimap file-icons travis-ci-status open-recent monokai-seti seti-ui todo-show highlight-selected minimap-highlight-selected autoclose-html pigments linter linter-javac linter-shellcheck linter-jsonlint linter-js-yaml auto-detect-indentation atom-beautify rest-client

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
sudo apt-add-repository -y ppa:rael-gc/scudcloud
sudo apt-get update
sudo apt-get install -y scudcloud

# Install Intellij idea
wget -O /tmp/idea.tar.gz https://download.jetbrains.com/idea/ideaIU-15.0.2.tar.gz
mkdir $HOME/apps/JetBrains --parents
tar -xf /tmp/idea.tar.gz -C $HOME/apps/JetBrains/
ln -s $HOME/apps/JetBrains/idea-IU-143.1184.17 $HOME/apps/JetBrains/intellij
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
