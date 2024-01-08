#!/bin/bash

echo "REJOICE! You are installing TheWisePigeon's dotfiles \n"
echo "Make sure you have Neovim and Git installed before proceeding"

# Check if Git is installed
if which git >/dev/null; then
  echo "Git is installed."
else
  echo "Git is not installed. Aborting installation"
  exit
fi

# configure tmux
# First check for tmux existence on user system
# Then create symlink of config from the dotfiles to ~/.config/tmux/tmux.conf
# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Run tmux and C-b I to install packages
