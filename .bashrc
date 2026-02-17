# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

source $HOME/.dotfiles/.aliases

source $HOME/.dotfiles/.env

source $HOME/.dotfiles/.bashfunctions.sh

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/joseph/go/bin
. "$HOME/.cargo/env"
