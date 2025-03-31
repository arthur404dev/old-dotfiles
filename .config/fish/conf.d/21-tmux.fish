# Checks if tmux is installed, if not, install it
if not test -f $BREW_PREFIX/bin/tmux
    echo "Installing Tmux..."
    $BREW_PREFIX/bin/brew install tmux
end

# Checks if gitmux is installed, if not, install it
if not test -f $BREW_PREFIX/bin/gitmux
    echo "Installing Gitmux..."
    $BREW_PREFIX/bin/brew tap arl/arl
    $BREW_PREFIX/bin/brew install gitmux
end

# # Start tmux if not already running
# if status is-interactive; and test -z "$TMUX"
#     bash ~/.scripts/tmux-create-random-session.sh
# end
