#!/bin/bash

set -o errexit

# Install default applications
sudo apt-get install xbmc vlc libreoffice libdvdread4 bundler pinta Shutter filezilla amarok banshee -y

# Wtyczki kodi
# http://iptvlive.org/component/weblinks/weblink/20-sd-xbmc?Itemid=435&task=weblink.go
# http://sd-xbmc.org/pl/content/jak-zainstalowa%C4%87-pluginvideopolishtvlive

# To play encrypted DVD - http://askubuntu.com/questions/500/how-can-i-play-encrypted-dvd-movies
# sudo /usr/share/doc/libdvdread4/install-css.sh

# Install XBMC
sudo apt-get install python-software-properties pkg-config -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:team-xbmc/ppa -y
sudo apt-get update -y
sudo apt-get install xbmc -y

# Install xfce4
# sudo apt-get install '^xfce4.*$' -y

# Install flash?
# sudo apt-get install flashplugin-installer flashplugin-nonfree-extrasound pepperflashplugin-nonfree adobe-flashplugin  -y
# echo "deb http://archive.canonical.com/ubuntu trusty partner" | sudo tee --append /etc/apt/sources.list
# echo "deb-src http://archive.canonical.com/ubuntu trusty partner" | sudo tee --append /etc/apt/sources.list

# Upgrade
sudo apt-get upgrade -y

# Remove obsolete packages
sudo apt-get autoremove -y

# INSTALL SPOTIFY
# echo "deb http://repository.spotify.com stable non-free" | sudo tee --append /etc/apt/sources.list
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59
# sudo apt-get update
# sudo apt-get install spotify-client -y
