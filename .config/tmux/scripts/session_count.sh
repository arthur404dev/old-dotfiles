#!/bin/bash

# Count the number of active tmux sessions
count=$(tmux list-sessions 2>/dev/null | wc -l | awk '{$1=$1};1')
echo "$count"
