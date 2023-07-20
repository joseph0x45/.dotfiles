#!/bin/bash
# Clipper 0.1
# Written by TheWisePigeon. Contribute on https://github.com/TheWisePigeon

arg1=$1

if [[ "$arg1" == "version" ]]; then
    echo "Clipper 0.0.1 by TheWisePigeon<https://github.com/TheWisePigeon>"
fi

if [[ "$arg1" == "init" ]]; then
    
# Unix based systems support for now
storage=~/.tdm.txt
if test -e "$storage";  then
    :
else
    touch "$storage"
fi
fi
