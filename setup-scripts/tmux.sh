# install tmux (make this depending on the sysyem)
yay -S tmux -y
# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# create symlink
sudo ln -s /home/$USER/.dotfiles/tmux ~/.config/tmux
