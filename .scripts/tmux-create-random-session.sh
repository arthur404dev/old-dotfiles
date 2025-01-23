#!/bin/bash

# Define the list of session names
session_names=(
  "amaterasu"
  "amun"
  "anubis"
  "aphrodite"
  "apollo"
  "ares"
  "athena"
  "bastet"
  "brahma"
  "fenrir"
  "freyja"
  "freyr"
  "frigg"
  "fuxi"
  "ganesha"
  "guanyin"
  "hachiman"
  "hades"
  "hanuman"
  "hermes"
  "horus"
  "indra"
  "isis"
  "izanagi"
  "izanami"
  "kagutsuchi"
  "kali"
  "loki"
  "nezha"
  "nuwa"
  "odin"
  "osiris"
  "poseidon"
  "quetzalcoatl"
  "ra"
  "set"
  "shiva"
  "susanoo"
  "thor"
  "thoth"
  "tsukuyomi"
  "vishnu"
  "wukong"
  "yama"
  "yandi"
  "zeus"
)

# Function to generate a random session name that's not in use
generate_random_name() {
  while true; do
    random_name=$(printf "%s\n" "${session_names[@]}" | shuf -n 1)
    if ! tmux has-session -t "$random_name" 2>/dev/null; then
      echo "$random_name"
      return
    fi
  done
}

# Generate a random session name
random_name=$(generate_random_name)

# Create a new tmux session and attach to it
tmux new-session -s "$random_name" -d

# Check if we're running from within a tmux session
if [ -n "$TMUX" ]; then
  # Switch to the new session
  tmux switch-client -t "$random_name"
else
  # Attach to the new session
  tmux attach-session -t "$random_name"
fi
