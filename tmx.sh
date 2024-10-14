#!/bin/bash

arg1=$1

if [[ "$arg1" == "version" ]]; then
    echo "tmx 0.0.1 by joseph<https://github.com/joseph0x45>"
fi

if [[ "$arg1" == "ls" ]]; then
    tmux ls
fi

if [[ "$arg1" == "init" ]]; then
    tmux && tmx restore
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

if [[ "$arg1" == "kill" ]]; then
    arg2=$2
    if [ -z "$arg2" ]; then
        echo "You have to specify the session name"
        exit
    fi
    tmux kill-session -t "$arg2"
fi

if [[ "$arg1" == "restore" ]]; then
    if [ -z "${TMUX}" ]; then
        echo "You are not in a tmux session"
        exit
    fi
    xdotool key ctrl+b ctrl+r
fi

if [[ "$arg1" == "save" ]]; then
    if [ -z "${TMUX}" ]; then
        echo "You are not in a tmux session"
        exit
    fi
    xdotool key ctrl+b ctrl+s
fi

if [[ "$arg1" == "quit" ]]; then
    if [ -z "${TMUX}" ]; then
        echo "You are not in a tmux session"
        exit
    fi
    xdotool key ctrl+b d
fi

if [[ "$arg1" == "clear" ]]; then
    if [ -z "${TMUX}" ]; then
        echo "Clearing all tmux sessions"
        tmux_process=$(pgrep tmux)
        echo "$tmux_process"
        echo "kill -9 $tmux_process"
        exit
    fi
fi
