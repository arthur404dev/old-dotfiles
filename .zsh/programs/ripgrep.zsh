# If ripgrep is not installed, install it
if [ ! -f $BREW_PREFIX/bin/rg ]; then
    echo "Installing ripgrep..."
    $BREW_PREFIX/bin/brew install ripgrep
fi

ensure_package ripgrep -b rg -s
