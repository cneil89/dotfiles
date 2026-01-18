#!/bin/bash

pacman -Q git &>/dev/null || sudo pacman -Sy --noconfirm --needed git

# Set root dir variable, if this is initiated via boot.sh script it sets the root to be used
# throughout the project.  If run by install.sh it will run from the executing directory
# which may be different.
export NOMAD_PATH=$HOME/.local/share/nomad-dots

echo -e "\nCloning dotfiles repo..."
rm -rf ~/.local/share/dotfiles
git clone https://github.com/cneil89/dotfiles.git $NOMAD_PATH >/devnull

echo -e "\nInstallation starting.."
source ~/.local/share/dotfiles/install.sh
