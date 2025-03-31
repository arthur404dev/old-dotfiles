function fix_history
    # Check if the history file exists
    if test -f ~/.local/share/fish/fish_history
        set backup_name "fish_history_"(date +%Y%m%d%H%M%S)"_bad"
        echo "(1/3) Creating backup $backup_name"

        # Create a timestamped backup of the history file
        cp ~/.local/share/fish/fish_history ~/.local/share/fish/$backup_name
        echo "(2/3) Attempt to repair file"
        
        # Attempt to repair the history file
        strings ~/.local/share/fish/$backup_name > ~/.local/share/fish/fish_history

        echo "(3/3) Reload History"
        # Fish automatically reloads history
        rm ~/.local/share/fish/$backup_name
    else
        echo "History file not found."
    end
end
