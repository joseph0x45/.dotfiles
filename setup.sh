#!/usr/bin/env bash
rm -rf /home/$USER/.config/i3
sudo ln -s /home/$USER/.dotfiles/i3 ~/.config/i3
sudo ln -s /home/$USER/.dotfiles/tmux ~/.config/tmux
sudo ln -s /home/$USER/.dotfiles/nvim ~/.config/nvim
sudo ln -s /home/$USER/.dotfiles/alacritty ~/.config/alacritty
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --ipv4
tmux source ~/.config/tmux/tmux.conf
git config --global init.defaultBranch main
git config --global --add --bool push.autoSetupRemote true
git config --global user.email "zozozozeph@gmail.com"
git config --global user.name "joseph0x45"
git config --global core.editor "nvim"

{
  echo ""
  echo "source \$HOME/.dotfiles/.aliases"
  echo ""
  echo "source \$HOME/.dotfiles/.env"
  echo ""
} >> "$HOME/.bashrc"
