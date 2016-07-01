#!/bin/bash

set -o errexit

# Script that restarts graphics after moving to NVidia

sudo apt-get remove --purge nvidia-*
#Start from scratch

sudo apt-get remove --purge xserver-xorg-video-nouveau xserver-xorg-video-nv
#Reinstall everything

sudo apt-get install nvidia-common
sudo apt-get install xserver-xorg-video-nouveau
sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
#Reconfigure the X server

sudo dpkg-reconfigure xserver-xorg
