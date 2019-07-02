#!/bin/bash

sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco main restricted' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco-updates main restricted' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco universe' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco-updates universe' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco multiverse' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco-updates multiverse' -y
sudo apt-add-repository 'http://pl.archive.ubuntu.com/ubuntu/ disco-backports main restricted universe multiverse' -y
sudo apt-add-repository 'http://security.ubuntu.com/ubuntu disco-security main restricted' -y
sudo apt-add-repository 'http://security.ubuntu.com/ubuntu disco-security universe' -y
sudo apt-add-repository 'http://security.ubuntu.com/ubuntu disco-security multiverse' -y
sudo apt-add-repository '[arch=amd64] http://packages.microsoft.com/repos/vscode stable main' -y
sudo apt-add-repository ppa:certbot/certbot -y