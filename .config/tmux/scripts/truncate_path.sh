#!/bin/bash

smart_truncate() {
    local input_path="$1"
    local char_limit=20
    local max_depth=3
    local abbreviate_length=0

    input_path=$(realpath "$input_path")

    # Check if the path is a Git Repository
    if git_root=$(git -C "$input_path" rev-parse --show-toplevel 2>/dev/null); then
        git_root=$(realpath "$git_root")

        # Handle the case where input_path is the git_root
        if [[ "$input_path" == "$git_root" ]]; then
            relative_path=""
        else
            relative_path="${input_path#$git_root/}"
        fi

        if [[ "$git_root" == "$HOME"* ]]; then
            # Replace $HOME with ~ for display
            git_root_display="~${git_root/#$HOME/}"
        else
            git_root_display="$git_root"
        fi

        # Abbreviate intermediate directories in the Git root
        git_root_abbrev=$(abbreviate_path "$git_root_display" "$abbreviate_length")

        # Truncate the relative path if it exists
        truncated_path=$(truncate_path "$relative_path" "$max_depth" "$char_limit")
        if [[ -n "$relative_path" ]]; then
            echo "${git_root_abbrev}/${truncated_path}"
        else
            echo "${git_root_abbrev}"
        fi
    else
        # Handle normal paths
        if [[ "$input_path" == "$HOME"* ]]; then
            # Replace $HOME with ~ for display
            input_path="~${input_path/#$HOME/}"
        fi
        truncated_path=$(truncate_path "$input_path" "$max_depth" "$char_limit")
        echo "$truncated_path"
    fi
}

truncate_path() {
    local path="$1"
    local max_depth="$2"
    local char_limit="$3"
    local truncated_parts=()

    # Split path into components
    IFS='/' read -ra parts <<<"$path"

    # Truncate folder names longer than the character limit
    for part in "${parts[@]}"; do
        if [[ ${#part} -gt $char_limit ]]; then
            part="${part:0:$char_limit}..."
        fi
        truncated_parts+=("$part")
    done

    # If the path is too deep, include only the last max_depth parts with ellipsis
    if [[ ${#truncated_parts[@]} -gt $max_depth ]]; then
        echo "󰇘/${truncated_parts[@]: -$max_depth}" | tr ' ' '/'
    else
        echo "${truncated_parts[@]}" | tr ' ' '/'
    fi
}

abbreviate_path() {
    local path="$1"
    local abbreviation_length="$2"
    local abbreviated_parts=()

    # Split path into components
    IFS='/' read -ra parts <<<"$path"

    # Abbreviate all components except the last one
    for ((i = 0; i < ${#parts[@]}; i++)); do
        # Skip the following paths / components
        if [[ "${parts[$i]}" == "~" ]]; then
            abbreviated_parts+=("${parts[$i]}")
        elif [[ "$i" -eq $((${#parts[@]} - 1)) ]]; then
            # Keep the last component as is
            abbreviated_parts+=("${parts[$i]}")
        else
            if [[ "$abbreviation_length" -eq 0 ]]; then
                # Replace the folder name with the following if abbreviation_length is 0
                abbreviated_parts+=("")
            else
                # Abbreviate folder names longer than the abbreviation length
                if [[ ${#parts[$i]} -gt $abbreviation_length ]]; then
                    abbreviated_parts+=("${parts[$i]:0:$abbreviation_length}")
                else
                    abbreviated_parts+=("${parts[$i]}")
                fi
            fi
        fi
    done

    echo "${abbreviated_parts[@]}" | tr ' ' '/'
}

# Check if an argument is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <path>" >&2
    exit 1
fi

smart_truncate "$1"
