function select_item
    set -l prompt $argv[1]
    set -l items $argv[2]
    set -l fallback_label $argv[3] # New parameter for fallback label
    set -l selected_item ""

    # Checks if fzf is installed and uses it if available, otherwise uses a basic selection
    if command -v fzf >/dev/null 2>&1
        set selected_item (echo $items | fzf --height=40% --layout=reverse --border --prompt="$prompt")
    else
        set -l i 1
        for item in (echo $items)
            echo "($i) $item"
            set i (math $i + 1)
        end

        set -l selected_index
        read -P "Select a "(test -n "$fallback_label"; and echo $fallback_label; or echo "item")" number: " selected_index
        set selected_item (echo $items | sed -n "$selected_index"p)
    end

    echo $selected_item
end
