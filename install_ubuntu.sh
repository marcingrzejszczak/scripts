#!/bin/bash

set -o errexit

# Script that installs all Ubuntu things

./install_main.sh
./install_multimedia.sh
./install_games.sh
