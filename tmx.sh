#!/bin/bash

arg1=$1

if [[ "$arg1" == "ls" ]]; then
    tmux ls
fi

if [[ "$arg1" == "new" ]]; then
    arg2=$2
    if [ -z "$arg2" ]; then
        echo "You have to specify the session name"
        exit
    fi
    tmux new-session -s "$arg2"
fi

if [[ "$arg1" == "link" ]]; then
    arg2=$2
    if [ -z "$arg2" ]; then
        echo "You have to specify the session name"
        exit
    fi
    tmux attach-session -t "$arg2"
fi

if [[ "$arg1" == "resume" ]]; then
    tmux run-shell "tmux-resurrect restore"
fi
