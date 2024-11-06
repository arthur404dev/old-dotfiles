# If bat is not installed, install it
if [ ! -f $BREW_PREFIX/bin/bat ]; then
    echo "Installing bat..."
    $BREW_PREFIX/bin/brew install bat
fi

# Alias to open bat
alias b="bat"
