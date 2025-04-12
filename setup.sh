#!/usr/bin/env bash
sudo ln -s /home/$USER/.dotfiles/i3 ~/.config/i3
sudo ln -s /home/$USER/.dotfiles/tmux ~/.config/tmux
sudo ln -s /home/$USER/.dotfiles/nvim ~/.config/nvim
sudo ln -s /home/$USER/.dotfiles/alacritty ~/.config/alacritty
# sudo ln -s /home/$USER/.dotfiles/scripts/enable-ipv6.sh /usr/local/bin/enable-ipv6
# sudo ln -s /home/$USER/.dotfiles/scripts/disable-ipv6.sh /usr/local/bin/disable-ipv6
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --ipv4
tmux source ~/.config/tmux/tmux.conf
git config --global init.defaultBranch main
git config --global --add --bool push.autoSetupRemote true
git config --global user.email "zozozozeph@gmail.com"
git config --global user.name "joseph0x45"
git config --global core.editor "nvim"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim --ipv4

{
  echo ""
  echo "source \$HOME/.dotfiles/.env"
  echo ""
} >> "$HOME/.bashrc"
