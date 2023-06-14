#!/bin/bash

# Unix based systems support for now
storage=~/.tdm.txt
if test -e "$storage";  then
    :
else
    touch "$storage"
fi

# Check if storage location exist, create it if not

# Priorities (Used runic equivalents to avoid any conflict)
# lowest = "ᛚᚢᛋᛏᛖ"
# medium = "ᛗᛖᛞᛁᚢᛗ"
# highest = "ᚺᛁᛋᛏᛖᛋᛏ"
# Entry format `task_name<->priority<->status`
# user interface: tdm new <task_name> <priority>
# user interface: tdm set <task_name | task_id> priority <priority>
# user interface: tdm set <task_name | task_id> status <status> (status can be done or due)

action=$1

if [[ "new" == "$action" ]]; then
    if [[ -z "$3" ]]; then
        priority="due"
    else
        priority=$3
    fi
    echo "$priority"
fi

if [[ "set" == "$action" ]]; then
    :
fi
