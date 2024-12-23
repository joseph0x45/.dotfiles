#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias get_idf='. $HOME/esp/esp-idf/export.sh'

# Go path setup
export PATH=$PATH:/usr/local/go/bin:/home/$USER/go/bin
. "$HOME/.cargo/env"

# Export custom env vars
export DOWNLOADS=~/Downloads/
export HOME=~/
export ESP_32_HOME="/home/joseph/esp/esp-idf/"

PATH="/home/joseph/perl5/bin${PATH:+:${PATH}}"; export PATH;
