# Set XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME $HOME/.config

# Detect environment
set -g IS_WSL (test -d /mnt/c; and echo true; or echo false)

# Remove Greeting Message
set -U fish_greeting

# Load all configuration files
# Fish automatically loads:
# - All .fish files in conf.d/ (alphabetically)
# - All functions in functions/
# - completions in completions/

# Load work-specific files if they exist
if test -d $HOME/.config/fish/work
    for file in $HOME/.config/fish/work/*.fish
        source $file
    end
end

# Load program-specific files if they exist
if test -d $HOME/.config/fish/programs
    for file in $HOME/.config/fish/programs/*.fish
        source $file
    end
end
