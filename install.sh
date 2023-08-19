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
