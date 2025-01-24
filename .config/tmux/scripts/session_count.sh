#!/bin/bash

# Count the number of active tmux sessions
tmux list-sessions 2>/dev/null | wc -l
