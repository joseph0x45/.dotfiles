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

PATH="/home/joseph/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/joseph/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/joseph/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/joseph/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/joseph/perl5"; export PERL_MM_OPT;
