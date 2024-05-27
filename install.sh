#!/bin/bash
sudo ln -s /home/$USER/.dotfiles/i3 ~/.config/i3
sudo ln -s /home/$USER/.dotfiles/tmux ~/.config/tmux
sudo ln -s /home/$USER/.dotfiles/nvim ~/.config/nvim
sudo ln -s /home/$USER/.dotfiles/alacritty ~/.config/alacritty
tmux source ~/.config/tmux/tmux.conf
git config --global init.defaultBranch main
git config --global --add --bool push.autoSetupRemote true
