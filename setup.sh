#!/usr/bin/env bash
rm ~/.bashrc
ln -s ~/.dotfiles/.bashrc ~/.bashrc
rm -rf ~/.config/i3
ln -s ~/.dotfiles/i3 ~/.config/i3
ln -s ~/.dotfiles/tmux ~/.config/tmux
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/alacritty ~/.config/alacritty
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --ipv4
tmux source ~/.config/tmux/tmux.conf
git config --global init.defaultBranch main
git config --global --add --bool push.autoSetupRemote true
git config --global user.email "zozozozeph@gmail.com"
git config --global user.name "joseph0x45"
git config --global core.editor "nvim"

# Setup fonts
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
