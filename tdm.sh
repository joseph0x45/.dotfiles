#!/bin/bash

change_first_letter() {
    local file_path="$1"
    local line_number="$2"
    local new_first_letter="$3"

    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path"
        return 1
    fi

    local total_lines=$(wc -l < "$file_path")
    if (( line_number <= 0 || line_number > total_lines )); then
        echo "Invalid line number: $line_number"
        return 1
    fi

    sed -i "${line_number}s/^\(.\)/$new_first_letter/" "$file_path"
    echo "Changes applied"
}


# Unix based systems support for now
storage=~/.tdm.txt
if test -e "$storage";  then
    :
else
    touch "$storage"
fi

action=$1

if [[ "clear" == "$action" ]]; then
    rm ~/.tdm.txt
    echo "Tasks cleared"
fi

if [[ "new" == "$action" ]]; then
    task_name="$2"
    echo "✗- $task_name" >> "$storage"
    echo "New task added"
fi


if [[ "$action" == "ls" ]]; then
    cat -n "$storage"
fi

if [[ "$action" == "lsd" ]]; then
    grep -n '^✓' "$storage" | awk -F: '{printf "(%d)  %s\n", $1, $2}'
fi

if [[ "$action" == "lstd" ]]; then
    grep -n '^✗' "$storage" | awk -F: '{printf "(%d)  %s\n", $1, $2}'
fi

if [[ "set-done" == "$action" ]]; then
    task_id=$2
    change_first_letter "$storage" $task_id "✓"
fi

if [[ "set-due" == "$action" ]]; then
    task_id=$2
    change_first_letter "$storage" $task_id "✗"
fi
