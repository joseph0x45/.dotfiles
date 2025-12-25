#!/bin/bash

current_session=$(tmux display-message -p '#S')

all_sessions=$(tmux list-sessions -F '#S')

for session in $all_sessions; 
do
    if [ "$session" != "$current_session" ]; 
    then
        tmux kill-session -t "$session"
    fi
done
